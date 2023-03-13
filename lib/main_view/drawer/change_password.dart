import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constants.dart' as consts;

class ChangePwd extends StatefulWidget {
  const ChangePwd({Key? key}) : super(key: key);

  @override
  State<ChangePwd> createState() => _ChangePwdState();
}

void showToast(s) {
  Fluttertoast.showToast(
      msg: s.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

class _ChangePwdState extends State<ChangePwd> {
  bool login = false;

  var email = TextEditingController();
  var currentPass = TextEditingController();
  var newPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(consts.BG),
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: const Color(consts.FONTC),
      ),
      body: Center(
        child:
            // login ?
            Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // const Text('Home Page'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  FirebaseAuth.instance.currentUser!.email!,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(consts.FONTC),
                  ),
                ),
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
                child: TextFormField(
                  obscureText: true,
                  controller: currentPass,
                  decoration: InputDecoration(
                      hintText: "Enter The Current Password",
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
                child: TextFormField(
                  obscureText: true,
                  controller: newPass,
                  decoration: InputDecoration(
                      hintText: "Enter The New Password",
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () async {
                    if (newPass.text.trim().length < 8) {
                      showToast(
                          "Update failed: Required at least 8 characters.");
                      return;
                    }
                    if (currentPass.text.trim() == newPass.text.trim()) {
                      showToast(
                          "Update failed: New Password is same as current Password.");
                      return;
                    }
                    if (currentPass.value.text.isNotEmpty &&
                        newPass.value.text.isNotEmpty) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: FirebaseAuth.instance.currentUser!.email!,
                            password: currentPass.text);
                        await FirebaseAuth.instance.currentUser!
                            .updatePassword(newPass.text);
                      } catch (e) {
                        showToast("Update failed: Check your credentials.");
                        return;
                      }
                      if (!mounted) return;
                      showToast("Update Successful");
                    }
                  },
                  child: Container(
                      width: w * 0.5,
                      height: h * 0.08,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage("img/g.jpg"),
                              fit: BoxFit.cover)),
                      child: Center(
                        child: Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(consts.FONTC),
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
