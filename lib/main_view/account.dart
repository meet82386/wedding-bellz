import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wedding_bellz/Authentication/auth_controller.dart';
import '../constants.dart' as consts;
import 'drawer/about_us.dart';
import 'drawer/change_password.dart';
import 'drawer/del_acc.dart';
import 'drawer/feedback.dart';
import 'drawer/change_info.dart';
import 'drawer/my_drawer_header.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var currentPage = DrawerSections.dashboard;

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
        title: const Text('Wedding Bellz'),
        backgroundColor: const Color(consts.FONTC),
      ),
      body: Container(
        child: Center(
          child: Text("Account Page."),
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
