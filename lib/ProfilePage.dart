import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/HomePage.dart';
import 'package:flutter_project/User%20Authentication/LoginPage.dart';
import 'package:flutter_project/User%20Authentication/UserAuthentication.dart';
import 'package:flutter_project/Models/UserModel.dart';

import 'Widgets/customAppBar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserModel user = UserAuthentication.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App'),
        backgroundColor: Colors.blue.shade200,
      ),
      bottomNavigationBar: CustomBottomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top:10),
        child: ListView(
          children: [
            Container(
            margin: EdgeInsets.only(top: 10, left: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  child: Icon(Icons.person),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    user.username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
          ElevatedButton(onPressed: _signOut, child: Text('Sign Out'))
          ],
        ),
      ),
    );
  }

  void _signOut() async{
    await FirebaseAuth.instance.signOut();
    UserAuthentication.currentUser = UserModel(id: "0", email: "", username: "username");
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
  }
}
