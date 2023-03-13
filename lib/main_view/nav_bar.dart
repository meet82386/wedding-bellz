import 'package:flutter/material.dart';
import 'home.dart';
import 'account.dart';
import 'cart.dart';
import 'categories.dart';
import '../constants.dart' as consts;

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  final tabs = [HomePage(), Categories(), Cart(), Account()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Color(consts.FONTC),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            label: "Catrgories",
            backgroundColor: Color(consts.FONTC),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business),
            label: "Cart",
            backgroundColor: Color(consts.FONTC),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Account",
            backgroundColor: Color(consts.FONTC),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
