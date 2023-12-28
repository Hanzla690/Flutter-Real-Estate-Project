import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_project/ChatsPage.dart';
import 'package:flutter_project/CreateHousePostPage.dart';
import 'package:flutter_project/FavoritesPage.dart';
import 'package:flutter_project/HomePage.dart';
import 'package:flutter_project/ProfilePage.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.white,
        color: Colors.green.shade500,
        animationDuration: const Duration(milliseconds: 400),
        height: 60.0,
        items: const [
          Icon(CupertinoIcons.home),
          Icon(Icons.message_outlined),
          Icon(CupertinoIcons.add),
          Icon(CupertinoIcons.heart),
          Icon(CupertinoIcons.person)
        ],

        onTap: (index) {
      setState(() {
        _page = index;
      });
      switch (index) {
        case 0:
        // Navigate to page 0
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
          break;
        case 1:
        // Navigate to page 1
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Chats()),
          );
          break;
        case 2:
        // Navigate to page 2
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CreatePost(editMode: false)),
          );
          break;
        case 3:
        // Navigate to page 3
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Favorites()),
          );
          break;
        case 4:
        // Navigate to page 4
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Profile()),
          );
          break;
      }
    },
    );
  }
}
