import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_project/AdPage.dart';
import 'package:flutter_project/ChatsPage.dart';
import 'package:flutter_project/CreateHousePostPage.dart';
import 'package:flutter_project/FavoritesPage.dart';
import 'package:flutter_project/HomePage.dart';
import 'package:flutter_project/MyAds.dart';
import 'package:flutter_project/User%20Authentication/UserAuthentication.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/bghome.jpg")
              ),
              color: Colors.teal,
            ),
              accountName: Text(UserAuthentication.currentUser.username,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              )),
              accountEmail: Text(UserAuthentication.currentUser.email,
              style: const TextStyle(
                color: Colors.black
              ),),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Icon(Icons.person,
                size: 90,
                color: Colors.green.shade500,
                // width: 90,
                // height: 90,
                //   fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListTile(
            selectedTileColor: Colors.green.shade200,
            leading: Icon(
              Icons.home,
              color: Colors.green.shade500,
            ),
            title: const Text("Home"),
             onTap: () {
               Navigator.pushReplacement(context, MaterialPageRoute(
                   builder: (context) => const MyHomePage()));
             },
          ),
          ListTile(
            selectedTileColor: Colors.teal.shade300,
            leading: Icon(
                Icons.favorite_outline,
              color: Colors.green.shade500,
            ),
            title: const Text("Favourites"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const Favorites()));
            },
          ),
          ListTile(
            selectedTileColor: Colors.teal.shade300,
            leading: Icon(
                Icons.chat_outlined,
              color: Colors.green.shade500,
            ),
            title: const Text("Chats"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const Chats()));
            },
          ),
          ListTile(
            selectedTileColor: Colors.teal.shade300,
            leading: Icon(
                Icons.add_circle_outline,
              color: Colors.green.shade500,
            ),
            title: const Text("Post Property Ad"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const CreatePost(editMode: false)));
            },
          ),
          ListTile(
            selectedTileColor: Colors.teal.shade300,
            leading: Icon(
                Icons.ads_click_outlined,
              color: Colors.green.shade500,
            ),
            title: const Text("My Ads"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const MyAdsPage()));
            },
          ),
          ListTile(
            selectedTileColor: Colors.teal.shade300,
            leading: const Icon(
                Icons.settings_accessibility_outlined
            ),
            title: const Text("Ad Check"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const AdPage()));
            },
          )
        ],
      ),
    );
  }
}
