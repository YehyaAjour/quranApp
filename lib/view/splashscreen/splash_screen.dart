import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:flutter/widgets.dart';
import 'package:quranapp/view/component/constants.dart';
import 'package:quranapp/view/layout/drawer.dart';
import 'package:quranapp/view/loginscreen/login_screen.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 300,
      splash: Image.asset(
        'assets/images/shatiby.png',
        fit: BoxFit.cover,
      ),
      nextScreen: token == null ? LoginScreen() : DrawerScreen(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
      animationDuration: Duration(seconds: 2),
      duration: 5,
      backgroundColor: Colors.white,
    );
  }
}
