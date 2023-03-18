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
      backgroundColor: const Color(consts.BG),
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: const Color(consts.FONTC),
      ),
      body: Center(
        child: Column(
          children: const [
            SizedBox(
              height: 50,
            ),
            Text(
              "Wedding Bellz",
              style: TextStyle(
                  fontSize: 40,
                  color: Color(consts.FONTC),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Color(consts.FONTC),
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
