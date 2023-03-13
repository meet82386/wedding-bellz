import 'package:flutter/material.dart';
import '../../constants.dart' as consts;

class Feedbacks extends StatefulWidget {
  const Feedbacks({Key? key}) : super(key: key);

  @override
  State<Feedbacks> createState() => _FeedbacksState();
}

class _FeedbacksState extends State<Feedbacks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(consts.BG),
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: const Color(consts.FONTC),
      ),
    );
  }
}
