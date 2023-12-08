import 'package:flutter/material.dart';
import 'package:flutter_project/ChatActivePage.dart';
import 'package:flutter_project/FireStoreCollections.dart';
import 'package:flutter_project/HomePage.dart';
import 'package:flutter_project/Models/HouseModel.dart';
import 'package:flutter_project/Models/UserModel.dart';
import 'package:flutter_project/User%20Authentication/UserAuthentication.dart';

class HouseDetails extends StatefulWidget {
  final imageUrl, house, user;

  const HouseDetails({super.key, this.imageUrl, this.house, this.user});

  @override
  State<HouseDetails> createState() =>
      _HouseDetailsState(imageUrl: imageUrl, house: house, userId: user);
}

class _HouseDetailsState extends State<HouseDetails> {
  final imageUrl, userId;
  final HouseModel house;

  _HouseDetailsState({this.imageUrl, required this.house, this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: OutlinedButton(
            onPressed: () async {
              if (userId == UserAuthentication.currentUser.id) {
                showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.pop(context);
                    });
                    return AlertDialog(
                      content: Text(
                        'This ad was posted by this account, so cannot chat with yourself',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                UserModel currentUser = UserAuthentication.currentUser;
                UserModel user = await FireStoreCollections().getUser(userId);
                if (currentUser.activeChats.isEmpty) {
                  currentUser.activeChats.add(user.id);
                } else {
                  for (var UserId in currentUser.activeChats) {
                    if (user.id != UserId) {
                      currentUser.activeChats.add(user.id);
                    }
                  }
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Chat(user: user)));
              }
            },
            child: Text('Chat')),
      ),
      body: ListView(
        children: [
          Image.network(
            imageUrl,
            height: 300,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            margin: EdgeInsets.only(top: 10, right: 3),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 5),
            ]),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    house.price.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "${house.address}, ${house.area}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Row(
                    children: [
                      Icon(Icons.bed_outlined),
                      Text('2'),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(Icons.bathtub_outlined),
                      Text('2'),
                    ],
                  ),
                  Text(
                    house.title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  Text(house.description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
