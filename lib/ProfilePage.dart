import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/HomePage.dart';
import 'package:flutter_project/User%20Authentication/LoginPage.dart';
import 'package:flutter_project/User%20Authentication/UserAuthentication.dart';
import 'package:flutter_project/Models/UserModel.dart';

import 'CreateHousePostPage.dart';
import 'FireStoreCollections.dart';
import 'HouseDetailsPage.dart';
import 'Widgets/bottom_nav_bar.dart';
import 'Widgets/customAppBar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // var imageUrl =
  //     'https://t4.ftcdn.net/jpg/02/79/95/39/360_F_279953994_TmVqT7CQhWQJRLXev4oFmv8GIZTgJF1d.jpg';
  UserModel user = UserAuthentication.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('App'),
      //   backgroundColor: Colors.blue.shade200,
      // ),
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              color: Colors.green.shade500,
            ),
            const Text(
              "Profile",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    child: Icon(
                      Icons.person,
                      color: Colors.green.shade500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      user.username,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            //  ElevatedButton(onPressed: _signOut, child: const Text('Sign Out'))
            ElevatedButton(
              onPressed: _signOut,
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green.shade400),
                  side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: Colors.white))),
              child: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    UserAuthentication.currentUser =
        UserModel(id: "0", email: "", username: "username");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false, 
    );
  }
}
