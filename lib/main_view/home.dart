import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../constants.dart' as consts;
import 'package:wedding_bellz/Authentication/auth_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeIndex = 0;
  final controller = CarouselController();
  late final urlImages;
  late var nameofUser = "Name";

  void getData() async {
    User? user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection("Sale")
        .doc("OOkLPbQGCeehoADtkqaP")
        .get();
    setState(() {
      urlImages = vari.data()!['Links'];
    });
  }

  void getName() async {
    User? user = await FirebaseAuth.instance.currentUser;

    var userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get();

    setState(() {
      nameofUser = userData.data()!['Name'];
    });
  }

  @override
  void initState() {
    getData();
    getName();
    super.initState();
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: const ExpandingDotsEffect(
            dotWidth: 15, activeDotColor: Colors.blue),
        activeIndex: activeIndex,
        count: urlImages.length,
      );

  void animateToSlide(int index) => controller.animateToPage(index);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: const Color(consts.BG),
        appBar: AppBar(
          actions: [
            Stack(
              children: [
                IconButton(
                    onPressed: () {
                      Get.offAll(() => const Notifications());
                    },
                    icon: const Icon(
                      Icons.notifications,
                    ))
              ],
            )
          ],
          title: const Text('Wedding Bellz'),
          backgroundColor: const Color(consts.FONTC),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                "Welcome ${nameofUser}",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(consts.FONTC),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CarouselSlider.builder(
                        carouselController: controller,
                        itemCount: urlImages.length,
                        itemBuilder: (context, index, realIndex) {
                          final urlImage = urlImages[index];
                          return Container(
                            decoration:
                                BoxDecoration(border: Border.all(width: 1)),
                            child: buildImage(
                              urlImage,
                              index,
                            ),
                          );
                        },
                        options: CarouselOptions(
                            height: 200,
                            autoPlay: true,
                            // enableInfiniteScroll: true,
                            autoPlayAnimationDuration: Duration(seconds: 5),
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) =>
                                setState(() => activeIndex = index))),
                    SizedBox(height: 15),
                    buildIndicator(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildImage(String urlImage, int index) =>
    Container(child: Image.network(urlImage, fit: BoxFit.cover));
