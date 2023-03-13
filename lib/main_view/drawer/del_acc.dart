import 'package:flutter/material.dart';
import '../../constants.dart' as consts;

class DelAcc extends StatefulWidget {
  const DelAcc({Key? key}) : super(key: key);

  @override
  State<DelAcc> createState() => _DelAccState();
}

class _DelAccState extends State<DelAcc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(consts.BG),
      appBar: AppBar(
        title: const Text('Delete Account'),
        backgroundColor: const Color(consts.FONTC),
      ),
    );
  }
}
