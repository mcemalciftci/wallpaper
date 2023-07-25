import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:wallpaper/screens/login_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/logo2.png',
              width: 300,
              height: 300,
            ),
          ),
          Text("Wallpapers", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),)
        ],
      ),
      splashIconSize: 300,
      nextScreen: LoginPage(),
      splashTransition: SplashTransition.sizeTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
      backgroundColor: Colors.white,
      duration: 4000,
    );
  }
}

