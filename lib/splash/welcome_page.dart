import 'dart:async';

import 'package:anime_nation/app/core/injector_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    verifyUserState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Lottie.asset('assets/lottie/welcome_animation.json',
            width: 350, frameRate: FrameRate.max),
      ),
    );
  }

  void verifyUserState() {
    Timer(const Duration(seconds: 3), () {
      if (locator.get<FirebaseAuth>().currentUser != null) {
        goToNextScreen("/dashboard");
      } else {
        goToNextScreen("/login");
      }
    });
  }

  void goToNextScreen(String screenName) =>
      Navigator.popAndPushNamed(context, screenName);
}
