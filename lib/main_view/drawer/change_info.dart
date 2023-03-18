import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constants.dart' as consts;

class ChangeInfo extends StatefulWidget {
  const ChangeInfo({Key? key}) : super(key: key);

  @override
  State<ChangeInfo> createState() => _ChangeInfoState();
}

void showToast(s) {
  Fluttertoast.showToast(
      msg: s.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0,
      backgroundColor: Colors.black38);
}

class _ChangeInfoState extends State<ChangeInfo> {
  bool isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  void getData() async {
    User? user = FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    setState(() {
      nameController.text = vari.data()!['Name'];
      mobileController.text = vari.data()!['Mobile'].toString();
      addressController.text = vari.data()!['Address'];
      areaController.text = vari.data()!['Area'];
      pinController.text = vari.data()!['PinCode'].toString();
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(consts.BG),
      appBar: AppBar(
        title: const Text('Change Information'),
        backgroundColor: const Color(consts.FONTC),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Name:",
                        style:
                            TextStyle(fontSize: 20, color: Color(consts.FONTC)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1, 1),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          // prefixIcon: Icon(Icons.nam, color:Colors.green),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Mobile Number",
                        style:
                            TextStyle(fontSize: 20, color: Color(consts.FONTC)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1, 1),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    child: TextField(
                      controller: mobileController,
                      decoration: InputDecoration(
                          prefixText: '+91',
                          // prefixIcon: Icon(Icons.email, color:Colors.green),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Address",
                        style:
                            TextStyle(fontSize: 20, color: Color(consts.FONTC)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1, 1),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    child: TextField(
                      controller: addressController,
                      decoration: InputDecoration(

                          // prefixIcon: Icon(Icons.email, color:Colors.green),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                      // keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Area",
                        style:
                            TextStyle(fontSize: 20, color: Color(consts.FONTC)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1, 1),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    child: TextField(
                      controller: areaController,
                      decoration: InputDecoration(
                          // prefixIcon: Icon(Icons.email, color:Colors.green),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Pin Code",
                        style:
                            TextStyle(fontSize: 20, color: Color(consts.FONTC)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1, 1),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    child: TextField(
                      controller: pinController,
                      decoration: InputDecoration(
                          // prefixIcon: Icon(Icons.email, color:Colors.green),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 60,

                        // elevated button created and given style
                        // and decoration properties
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(consts.FONTC)),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            if (nameController.text.trim() == "" ||
                                mobileController.text.trim() == "" ||
                                addressController.text.trim() == "" ||
                                areaController.text.trim() == "" ||
                                pinController.text.trim() == "") {
                              showToast("Fields can not be empty");
                              return;
                            }
                            int mobile_int =
                                int.parse(mobileController.text.trim());
                            int zip_int = int.parse(pinController.text.trim());
                            if (mobileController.text.trim().length != 10) {
                              showToast("Invalid Mobile Number");
                              return;
                            }
                            if (pinController.text.trim().length != 6) {
                              showToast("Invalid Pin Code");
                              return;
                            }

                            User? user = FirebaseAuth.instance.currentUser;
                            var vars = await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user?.uid)
                                .update({
                              "Name": nameController.text.trim(),
                              "Address": addressController.text.trim(),
                              "Area": areaController.text.trim(),
                              "PinCode": zip_int,
                              "Mobile": mobile_int
                            });

                            Future.delayed(const Duration(seconds: 1), () {
                              setState(() {
                                isLoading = false;
                              });
                            });
                            showToast("Data Updated Successfully.");
                          },
                          child: isLoading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  // as elevated button gets clicked we will see text"Loading..."
                                  // on the screen with circular progress indicator white in color.
                                  //as loading gets stopped "Submit" will be displayed
                                  children: const [
                                    Text(
                                      'Loading...',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ],
                                )
                              : const Text(
                                  'Update',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
