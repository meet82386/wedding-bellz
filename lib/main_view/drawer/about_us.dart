import 'package:flutter/material.dart';
import '../../constants.dart' as consts;

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(consts.BG),
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: const Color(consts.FONTC),
      ),
    );
  }
}
