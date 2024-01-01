import 'package:flutter/material.dart';
import 'package:flutter_project/ChatActivePage.dart';
import 'package:flutter_project/FireStoreCollections.dart';
import 'package:flutter_project/HomePage.dart';
import 'package:flutter_project/HouseFunctions.dart';
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
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        //toolbarHeight: 80,
        title: const Text(
          "House Details",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: OutlinedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green.shade400),
                side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(color: Colors.white))),
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
            child: const Text(
              'Chat',
              style: TextStyle(color: Colors.white),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0), // Adjust the horizontal padding as needed
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(15.0), // Adjust the radius as needed
                child: Image.network(
                  imageUrl,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit
                      .cover, // You can adjust the BoxFit based on your requirements
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.only(top: 10, right: 3),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(color: Colors.grey, blurRadius: 5),
              ]),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          house.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        const Expanded(
                            child: SizedBox(
                          width: 1,
                        )),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Rs.${HouseFunctions().formatPrice(house.price)}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      house.areaSize,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "${house.address}, ${house.area}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Divider(
                      thickness: 4,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Text(
                      "Description",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(house.description),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
