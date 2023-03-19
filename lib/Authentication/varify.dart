import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../main_view/home.dart';
import '../constants.dart' as consts;

class VarifyEmail extends StatefulWidget {
  const VarifyEmail({Key? key}) : super(key: key);

  @override
  State<VarifyEmail> createState() => _VarifyEmailState();
}

class _VarifyEmailState extends State<VarifyEmail> {
  bool isEmailVerified = false;
  bool canResendEmail = false;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 2),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = false);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomePage()
      : Scaffold(
          backgroundColor: const Color(consts.BG),
          appBar: AppBar(
            title: const Text('Email Varification'),
            backgroundColor: const Color(consts.FONTC),
          ),
          body: Container(
            color: Color(consts.BG),
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ('A verification mail has been sent to your adress. check SPAM folder if you did not find it in inbox'),
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      color: Colors.green,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(consts.FONTC),
                          minimumSize: Size.fromHeight(50),
                        ),
                        icon: Icon(
                          Icons.email,
                          size: 32,
                        ),
                        label: Text(
                          'Resend Email',
                          style: TextStyle(fontSize: 24),
                        ),
                        onPressed: () {
                          if (canResendEmail) {
                            sendVerificationEmail();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                      ),
                      child: Text(
                        'Cancel',
                        style:
                            TextStyle(fontSize: 24, color: Color(consts.FONTC)),
                      ),
                      onPressed: () => FirebaseAuth.instance.signOut(),
                    )
                  ],
                )),
          ));
}
