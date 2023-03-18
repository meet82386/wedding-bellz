import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants.dart' as consts;

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
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

class _CartState extends State<Cart> {
  var rol;
  var list = [];

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> getData() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();

    rol = doc.data()!['cart'];
    list = list + rol;

    setState(() {
      print(list);
    });
  }

  void initState() {
    getData();
    super.initState();
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(consts.FONTC)),
                      child: Row(
                        children: const [
                          Icon(Icons.add_circle_outline),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Rent',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final docRef = await FirebaseFirestore.instance
                            .collection("users")
                            .doc(auth.currentUser!.uid)
                            .update({
                          'cart': FieldValue.arrayRemove([categories]),
                        }).then((value) => {
                                  setState(() async {
                                    list = [];
                                    await getData();
                                  })
                                });
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Row(
                        children: const [
                          Icon(Icons.remove_circle_outline),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Remove',
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
    return Container(
      child: Scaffold(
        backgroundColor: const Color(consts.BG),
        appBar: AppBar(
          title: const Text(
            'Cart',
          ),
          backgroundColor: const Color(consts.FONTC),
        ),
        body: ListView(
          children: list.map((value) {
            return WidgetCat(categories: value);
          }).toList(),
        ),
      ),
    );
  }
}
