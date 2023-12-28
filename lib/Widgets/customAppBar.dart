import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ChatsPage.dart';
import '../CreateHousePostPage.dart';
import '../FavoritesPage.dart';
import '../HomePage.dart';
import '../ProfilePage.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({super.key});

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  _CustomBottomAppBarState();
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 68,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: ((context) => const MyHomePage())));
                },
                child: const Column(
                  children: [
                    Icon(CupertinoIcons.home),
                    Text("Home"),
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Chats()));
                },
                child: const Column(
                  children: [
                    Icon(Icons.message),
                    Text("Chats"),
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>  const CreatePost(editMode: false)));
                  },
                  child: const Icon(Icons.add))),
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Favorites())));
                },
                child: const Column(
                  children: [
                    Icon(CupertinoIcons.heart_fill, color: Colors.red),
                    Text("Favorites"),
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
                child: const Column(
                  children: [
                    Icon(Icons.person),
                    Text("Profile"),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
