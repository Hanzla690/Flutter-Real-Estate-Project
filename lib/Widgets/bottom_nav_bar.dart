import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.green.shade500,
        animationDuration: const Duration(milliseconds: 400),
        height: 60.0,
        items: const [
          Icon(CupertinoIcons.home),
          Icon(CupertinoIcons.search),
          Icon(CupertinoIcons.heart),
          Icon(Icons.message_outlined),
          Icon(CupertinoIcons.person)
        ]
    );
  }
}
