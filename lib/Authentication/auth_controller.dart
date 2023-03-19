import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wedding_bellz/Authentication/login_page.dart';
import 'package:wedding_bellz/Authentication/varify.dart';
import '../database.dart';
import '../listing.dart';
import '../main_view/nav_bar.dart';

void showToast(String s) {
  Fluttertoast.showToast(
      msg: s,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

class AuthController extends GetxController {
  // AuthController.instance from other pages.
  static AuthController instance = Get.find();
  late Rx<User?> _user;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginPage());
    } else if (auth.currentUser?.email == "admin@gmail.com") {
      Get.offAll(() => Listing());
    } else {
      if (user.emailVerified) {
        Get.offAll(() => NavBar());
      }
    }
  }

  void register(String email, String password, String name, String dob,
      String mobile, String address, String area, String zip) async {
    try {
      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email)) {
        showToast("Invalid Email");
        return;
      }
      if (password.length < 8) {
        showToast("Invalid password");
        return;
      }
      if (name == "" ||
          mobile == "" ||
          address == "" ||
          area == "" ||
          zip == "") {
        showToast("Fields can not be empty");
        return;
      }
      int mobile_int = int.parse(mobile), zip_int = int.parse(zip);
      if (mobile.length != 10) {
        showToast("Invalid Mobile Number");
        return;
      }
      if (zip.length != 6) {
        showToast("Invalid Pin Code");
        return;
      }

      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      Map<String, dynamic> userInfoMap = {
        "Email": email,
        "Name": name,
        "Mobile": mobile_int,
        "birthDate": dob,
        "Address": address,
        "Area": area,
        "PinCode": zip_int,
        "orders": [],
        "cart": [],
        "profile-image":
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png',
      };
      DatabaseMethods().addUserInfoToDBUser(auth.currentUser!.uid, userInfoMap);
      await Get.offAll(() => const VarifyEmail());
    } catch (e) {
      showToast("Account Creation Failed. $e");
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      showToast("Sign in Failed. $e");
    }
  }

  void logout() async {
    await auth.signOut();
  }
}
