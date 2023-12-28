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
  var imageUrl =
      'https://t4.ftcdn.net/jpg/02/79/95/39/360_F_279953994_TmVqT7CQhWQJRLXev4oFmv8GIZTgJF1d.jpg';
  UserModel user = UserAuthentication.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App'),
        backgroundColor: Colors.blue.shade200,
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    child: Icon(Icons.person),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      user.username,
                      style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            // FutureBuilder(
            //   future: FireStoreCollections().fetchHouses(userID: user.id, searchMode: false),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return Column(
            //           children: List.generate(snapshot.data!.length, (index) {
            //             return Container(
            //               child: InkWell(
            //                 onTap: () {
            //                   Navigator.push(context,
            //                       MaterialPageRoute(builder: (context) {
            //                         return HouseDetails(
            //                           house: snapshot.data![index],
            //                           user: snapshot.data![index].userId,
            //                           imageUrl: imageUrl,
            //                         );
            //                       }));
            //                 },
            //                 child: Row(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Row(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Image.network(
            //                           imageUrl,
            //                           height: 120,
            //                           width: 120,
            //                           fit: BoxFit.cover,
            //                         ),
            //                         Padding(
            //                           padding: EdgeInsets.only(top: 12, left: 10),
            //                           child: Column(
            //                             crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                             mainAxisAlignment: MainAxisAlignment.start,
            //                             children: [
            //                               Text(
            //                                 snapshot.data![index].price.toString(),
            //                                 style: TextStyle(
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                               Text(
            //                                   "${snapshot.data![index].address} ${snapshot.data![index].area}"),
            //                             ],
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     Row(
            //                       children: [
            //                         Column(
            //                             mainAxisAlignment: MainAxisAlignment.start,
            //                             children: [
            //                               SizedBox(
            //                                 height: 7,
            //                               ),
            //                               ElevatedButton(
            //                                   style: ElevatedButton.styleFrom(
            //                                       fixedSize: Size(100, 25),
            //                                       side: BorderSide(
            //                                           color: Colors.black)),
            //                                   onPressed: () {
            //                                     Navigator.push(
            //                                         context,
            //                                         MaterialPageRoute(
            //                                           builder: (context) =>
            //                                               CreatePost(
            //                                                 editMode: true,
            //                                                 house:
            //                                                 snapshot.data![index],
            //                                               ),
            //                                         ));
            //                                   },
            //                                   child: Text(
            //                                     "Edit",
            //                                     style:
            //                                     TextStyle(color: Colors.black),
            //                                   )),
            //                               SizedBox(
            //                                 height: 7,
            //                               ),
            //                               ElevatedButton(
            //                                   style: ElevatedButton.styleFrom(
            //                                       fixedSize: Size(100, 25),
            //                                       side: BorderSide(
            //                                           color: Colors.red)),
            //                                   onPressed: () {
            //                                     showDialog(
            //                                       context: context,
            //                                       builder: (context) {
            //                                         return AlertDialog(
            //                                           title: Text(
            //                                               "Delete Confirmation"),
            //                                           content: Text(
            //                                               "Are you sure you want to delete this Ad?"),
            //                                           actions: [
            //                                             ElevatedButton(
            //                                                 style: ElevatedButton
            //                                                     .styleFrom(
            //                                                     side: BorderSide(
            //                                                         color: Colors
            //                                                             .red)),
            //                                                 onPressed: () async {
            //                                                   Navigator.pop(
            //                                                       context);
            //                                                   await FireStoreCollections()
            //                                                       .deleteHouseAd(
            //                                                       snapshot
            //                                                           .data![
            //                                                       index]
            //                                                           .houseId);
            //                                                   setState(() {});
            //                                                 },
            //                                                 child: Text(
            //                                                   "Yes",
            //                                                   style: TextStyle(
            //                                                       color:
            //                                                       Colors.red),
            //                                                 )),
            //                                             ElevatedButton(
            //                                                 style: ElevatedButton
            //                                                     .styleFrom(
            //                                                     side: BorderSide(
            //                                                         color: Colors
            //                                                             .black)),
            //                                                 onPressed: () {
            //                                                   Navigator.pop(
            //                                                       context);
            //                                                 },
            //                                                 child: Text(
            //                                                   "Cancel",
            //                                                   style: TextStyle(
            //                                                       color:
            //                                                       Colors.black),
            //                                                 )),
            //                                           ],
            //                                         );
            //                                       },
            //                                     );
            //                                   },
            //                                   child: Text(
            //                                     "Delete",
            //                                     style: TextStyle(color: Colors.red),
            //                                   )),
            //                             ]),
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             );
            //           }));
            //     }
            //     else{
            //       return const AlertDialog(
            //         actions: [
            //           LinearProgressIndicator()
            //         ],
            //       );
            //     }
            //   },
            // ),
            ElevatedButton(onPressed: _signOut, child: const Text('Sign Out'))
          ],
        ),
      ),
    );
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    UserAuthentication.currentUser =
        UserModel(id: "0", email: "", username: "username");
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
  }
}