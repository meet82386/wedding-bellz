import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart' as consts;

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({Key? key}) : super(key: key);

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  var image = "";
  var name = "";
  var mail = "";

  void getData() async {
    User? user = await FirebaseAuth.instance.currentUser;

    var userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get();

    setState(() {
      name = userData.data()!['Name'];
      image = userData.data()!['profile-image'];
      mail = userData.data()!['Email'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(consts.BG),
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(image),
                )),
          ),
          Text(
            name,
            style: TextStyle(
                color: Color(consts.FONTC),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            mail,
            style: TextStyle(
              color: Color(consts.FONTC),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
