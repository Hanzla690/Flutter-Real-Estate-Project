import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/FireStoreCollections.dart';
import 'package:flutter_project/HomePage.dart';
import 'package:flutter_project/User%20Authentication/LoginPage.dart';
import 'package:flutter_project/User%20Authentication/UserAuthentication.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/animation.json"),
      duration: 4000,
      nextScreen: LogInChecker(),
      splashIconSize: 250,
      backgroundColor: Colors.green.shade400,
      splashTransition: SplashTransition.slideTransition,
    );
  }
}

class LogInChecker extends StatelessWidget {
  const LogInChecker({Key? key});

  Future<bool?> _getLoggedInValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? loggedInValue = prefs.getBool('isLoggedIn');

    if (loggedInValue != null && loggedInValue) {
      String? userID = prefs.getString('userID');
      if (userID != null) {
        UserAuthentication.currentUser =
            await FireStoreCollections().getUser(userID);
      }
    }
    return loggedInValue;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool?>(
      future: _getLoggedInValue(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          return const MyHomePage();
        } else {
          return const Login();
        }
      },
    );
  }
}

