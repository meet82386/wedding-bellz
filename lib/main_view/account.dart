import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wedding_bellz/Authentication/auth_controller.dart';
import '../constants.dart' as consts;
import 'drawer/about_us.dart';
import 'drawer/change_password.dart';
import 'drawer/del_acc.dart';
import 'drawer/feedback.dart';
import 'drawer/change_info.dart';
import 'drawer/my_drawer_header.dart';
import 'dart:io';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var currentPage = DrawerSections.dashboard;
  ImagePicker picker = ImagePicker();
  XFile? file;
  String imageUrl = '';

  String name = "a";

  void getData() async {
    User? user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get();
    setState(() {
      name = vari.data()!['Name'];
      imageUrl = vari.data()!['profile-image'];
    });
  }

  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(consts.BG),
      appBar: AppBar(
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    AuthController.instance.logout();
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 30,
                  ))
            ],
          )
        ],
        title: const Text('My Account'),
        backgroundColor: const Color(consts.FONTC),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Color(consts.BG),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 150,
                            width: 150,
                            color: Colors.black12,
                            child: Container(
                              child: imageUrl == ''
                                  ? Icon(
                                      Icons.image,
                                      size: 40,
                                    )
                                  : SizedBox(
                                      child: Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            )),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                ),
                              ],
                              color: Color(consts.FONTC),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: InkWell(
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.white,
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet()),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "$name",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.black,
                            indent: 30,
                            endIndent: 30,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(consts.BG),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      decoration: BoxDecoration(color: Color(consts.BG)),
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Change Information", Icons.people_alt_outlined,
              currentPage == DrawerSections.changeAccInfo ? true : false),
          menuItem(3, "Change Password", Icons.password,
              currentPage == DrawerSections.changePassword ? true : false),
          menuItem(4, "Feedback", Icons.feedback_rounded,
              currentPage == DrawerSections.feedback ? true : false),
          menuItem(5, "About Us", Icons.account_balance_outlined,
              currentPage == DrawerSections.aboutUs ? true : false),
          menuItem(6, "Log Out", Icons.logout,
              currentPage == DrawerSections.logout ? true : false),
          menuItem(7, "Delete Account", Icons.delete_forever,
              currentPage == DrawerSections.deleteAcc ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.changeAccInfo;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChangeInfo()),
              );
            } else if (id == 3) {
              currentPage = DrawerSections.changePassword;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChangePwd()),
              );
            } else if (id == 4) {
              currentPage = DrawerSections.feedback;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Feedbacks()),
              );
            } else if (id == 5) {
              currentPage = DrawerSections.aboutUs;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUs()),
              );
            } else if (id == 6) {
              currentPage = DrawerSections.logout;
              AuthController.instance.logout();
            } else if (id == 7) {
              currentPage = DrawerSections.deleteAcc;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DelAcc()),
              );
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(consts.FONTC))),
                icon: Icon(Icons.camera),
                onPressed: () async {
                  ImagePicker imagePicker = ImagePicker();
                  file =
                      await imagePicker.pickImage(source: ImageSource.camera);

                  // file = await imagePicker.pickImage(
                  //     source: ImageSource.gallery);

                  print('${file?.path}');
                  setState(() {});
                  if (file == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please upload an image')));

                    return;
                  }

                  String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  FirebaseAuth auth = FirebaseAuth.instance;
                  String? mail = auth.currentUser!.email;
                  // String? fname = auth.currentUser!.fname;
                  Reference referenceDirImages =
                      referenceRoot.child(mail.toString());

                  Reference referenceImageToUpload =
                      referenceDirImages.child(uniqueFileName);
                  try {
                    //Store the file
                    await referenceImageToUpload.putFile(File(file!.path));
                    //Success: get the download URL
                    imageUrl = await referenceImageToUpload.getDownloadURL();
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(auth.currentUser!.uid)
                        .update({'profile-image': imageUrl});
                    setState(() {});
                  } catch (error) {
                    print("Some error occured");
                  }
                },
                label: Text("Camera"),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(consts.FONTC))),
                icon: Icon(Icons.image),
                onPressed: () async {
                  ImagePicker imagePicker = ImagePicker();

                  // file = await imagePicker.pickImage(source: ImageSource.camera);

                  file =
                      await imagePicker.pickImage(source: ImageSource.gallery);

                  print('${file?.path}');
                  setState(() {});
                  if (file == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please upload an image')));

                    return;
                  }

                  String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  FirebaseAuth auth = FirebaseAuth.instance;
                  String? mail = auth.currentUser!.email;
                  // String? fname = auth.currentUser!.fname;
                  Reference referenceDirImages =
                      referenceRoot.child(mail.toString());

                  Reference referenceImageToUpload =
                      referenceDirImages.child(uniqueFileName);
                  try {
                    //Store the file
                    await referenceImageToUpload.putFile(File(file!.path));
                    //Success: get the download URL
                    imageUrl = await referenceImageToUpload.getDownloadURL();
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(auth.currentUser!.uid)
                        .update({'profile-image': imageUrl});
                    setState(() {});
                  } catch (error) {
                    print("Some error occured");
                  }
                },
                label: Text("Gallery"),
              )
            ],
          ),
        ],
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  changeAccInfo,
  changePassword,
  feedback,
  aboutUs,
  logout,
  deleteAcc,
}
