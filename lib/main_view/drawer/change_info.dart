import 'package:flutter/material.dart';
import '../../constants.dart' as consts;

class ChangeInfo extends StatefulWidget {
  const ChangeInfo({Key? key}) : super(key: key);

  @override
  State<ChangeInfo> createState() => _ChangeInfoState();
}

class _ChangeInfoState extends State<ChangeInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(consts.BG),
      appBar: AppBar(
        title: const Text('Change Information'),
        backgroundColor: const Color(consts.FONTC),
      ),
    );
  }
}
