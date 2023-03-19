import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../constants.dart' as consts;

class PertCategory extends StatefulWidget {
  const PertCategory({Key? key, required this.category}) : super(key: key);
  final String category;
  @override
  State<PertCategory> createState() => _PertCategoryState();
}

void showToast(String s) {
  Fluttertoast.showToast(
      msg: s,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

class _PertCategoryState extends State<PertCategory> {
  var rol;
  var list = [];
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> getData() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('Categories').get();

    for (var doc in querySnapshot.docs) {
      // Getting data directly

      rol = doc.get('data');
      if (rol[0]['category'] == widget.category) {
        list = list + rol;
      }
    }
    setState(() {
      print(list);
    });
  }

  String name = '', mobile = '', email = '';
  void getUserData() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('Email', isEqualTo: auth.currentUser!.email)
        .get();

    for (var doc in querySnapshot.docs) {
      // Getting data directly
      name = doc.get('Name');
      email = doc.get('Email');
      mobile = doc.get('Mobile');
    }
    setState(() {});
  }

  late Razorpay _razorpay;
  var ordered;

  void initState() {
    _razorpay = Razorpay();
    getData();
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Widget WidgetCat({required Map categories}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
          ),
        ],
        border: Border.all(width: 1, color: Color(consts.FONTC)),
        color: const Color(consts.LIGHT),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      // padding: const EdgeInsets.all(8),
      height: 140,
      child: Row(
        children: [
          Container(
            width: 100,
            height: 140,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Color(consts.FONTC)),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              image: DecorationImage(
                  image: NetworkImage(categories['url']), fit: BoxFit.fill),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4.0, left: 20.0),
            child: Column(
              children: [
                Container(
                  // padding: const EdgeInsets.all(10),
                  child: Text(
                    categories['name'],
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(consts.FONTC),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  child: Text(
                    "Price: ${categories['price']} INR",
                    style: TextStyle(
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                      color: Color(consts.FONTC),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  child: categories['quantity'] != 0
                      ? Text(
                          "Quantity: ${categories['quantity']}",
                          style: TextStyle(
                            fontSize: 20,
                            // fontWeight: FontWeight.bold,
                            color: Color(consts.FONTC),
                          ),
                          textAlign: TextAlign.start,
                        )
                      : Text(
                          "Out of Stock",
                          style: TextStyle(
                            fontSize: 20,
                            // fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.start,
                        ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: categories['quantity'] == 0
                          ? null
                          : () async {
                              ordered = categories;
                              openCheckout(categories['price']);
                            },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(consts.FONTC)),
                      child: Row(
                        children: const [
                          Icon(Icons.add_circle_outline),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Rent',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(auth.currentUser?.uid)
                            .set({
                          "cart": FieldValue.arrayUnion([categories])
                        }, SetOptions(merge: true));
                        showToast('Added to the Cart');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(consts.FONTC)),
                      child: Row(
                        children: const [
                          Icon(Icons.add_shopping_cart),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Cart',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(consts.BG),
      appBar: AppBar(
        title: Text('${widget.category} wear'),
        backgroundColor: const Color(consts.FONTC),
      ),
      body: ListView(
        children: list.map((value) {
          return WidgetCat(categories: value);
        }).toList(),
      ),
    );
  }

  void openCheckout(amount) async {
    getUserData();
    var options = {
      'key': 'rzp_test_WiN33F3FtHlokB',
      'amount': (amount * 100.roundToDouble()).toString(),
      'name': name,
      'description': '',
      'prefill': {'contact': mobile, 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      // debugPrint(e);
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Scaffold.of(context).showSnackBar(SnackBar(content: Text("SUCCESS: ${response.paymentId}")));
    Fluttertoast.showToast(
        msg: "SUCCESS: ${response.paymentId}", timeInSecForIosWeb: 4);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser?.uid)
        .set({
      "orders": FieldValue.arrayUnion([ordered])
    }, SetOptions(merge: true));

    final docRef = await FirebaseFirestore.instance
        .collection("Categories")
        .doc(ordered['category'])
        .update({
      'data': FieldValue.arrayRemove([ordered]),
    });
    ordered['quantity'] = ordered['quantity'] - 1;

    await FirebaseFirestore.instance
        .collection("Categories")
        .doc(ordered['category'])
        .set({
      "data": FieldValue.arrayUnion([ordered])
    }, SetOptions(merge: true));
    setState(() {});
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Scaffold.of(context).showSnackBar(SnackBar(content: Text("ERROR: " + response.code.toString() + " - " + response.message)));
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - ",
        timeInSecForIosWeb: 4);
  }

  Future<void> _handleExternalWallet(ExternalWalletResponse response) async {
    // Scaffold.of(context).showSnackBar(SnackBar(content: Text("EXTERNAL_WALLET: ${response.walletName}")));
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ${response.walletName}", timeInSecForIosWeb: 4);

    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET 2: ${response.walletName}",
        timeInSecForIosWeb: 4);
  }
}
