import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/User%20Authentication/LoginPage.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
         splash: Lottie.asset("assets/animation.json"),
      // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Image.asset("assets/malikriaz.jpg"),
        //     const Text("Welcome to PakHomes",
        //       style: TextStyle(
        //         color: Colors.white70,
        //         fontSize: 40,
        //         fontWeight: FontWeight.bold
        //       ),)
        //   ],
        // ),
        duration: 4000,
        nextScreen: const Login(),
        splashIconSize: 250,
      backgroundColor: Colors.green.shade400,
      splashTransition: SplashTransition.slideTransition,
    );
  }
}
