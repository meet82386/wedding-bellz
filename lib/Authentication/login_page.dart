import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wedding_bellz/Authentication/auth_controller.dart';
import 'package:wedding_bellz/Authentication/sign_up.dart';
import '../constants.dart' as consts;
import 'forgot_pass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(consts.BG),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                children: [
                  const Text(
                    "Wedding Bellz",
                    style: TextStyle(
                        fontSize: 50,
                        color: Color(consts.FONTC),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 30,
                        color: Color(consts.FONTC),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: const [
                      Text(
                        "E-mail:",
                        style:
                            TextStyle(fontSize: 20, color: Color(consts.FONTC)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: const Offset(1, 1),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "xyz@gmail.com",
                          prefixIcon: const Icon(Icons.email,
                              color: Color(consts.FONTC)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Text(
                        "Password:",
                        style:
                            TextStyle(fontSize: 20, color: Color(consts.FONTC)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: const Offset(1, 1),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    child: TextField(
                      controller: passwordController,
                      obscureText: !_isVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          icon: _isVisible
                              ? const Icon(
                                  Icons.visibility,
                                  color: Color(consts.FONTC),
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Color(consts.FONTC),
                                ),
                        ),
                        // focusedBorder: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(10),
                        //     borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0)),
                        hintText: "Password",
                        prefixIcon:
                            const Icon(Icons.lock, color: Color(consts.FONTC)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      RichText(
                          text: TextSpan(
                        text: "Forgot Password ?",
                        style: const TextStyle(
                            color: Color(consts.FONTC), fontSize: 20),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(() => const Forgot_Pass()),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 60,

                      // elevated button created and given style
                      // and decoration properties
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(consts.FONTC)),
                        onPressed: () {
                          AuthController.instance.login(
                              emailController.text.trim(),
                              passwordController.text.trim());
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 20),
                        ),
                      )),
                  SizedBox(height: h * 0.09),
                  RichText(
                      text: TextSpan(
                          text: "Don't Have an Account? ",
                          style: const TextStyle(
                              color: Color(consts.FONTC), fontSize: 20),
                          children: [
                        TextSpan(
                          text: "Create",
                          style: const TextStyle(
                              color: Color(consts.FONTC),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => const SignUpPage()),
                        )
                      ]))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
