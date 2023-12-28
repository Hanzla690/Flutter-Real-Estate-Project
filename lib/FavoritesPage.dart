import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/FireStoreCollections.dart';
import 'package:flutter_project/HomePage.dart';
import 'package:flutter_project/HouseDetailsPage.dart';
import 'package:flutter_project/HouseFunctions.dart';
import 'package:flutter_project/User%20Authentication/UserAuthentication.dart';
import 'package:flutter_project/Widgets/bottom_nav_bar.dart';
import 'package:flutter_project/Widgets/loadShimmer.dart';
import 'package:shimmer/shimmer.dart';

import 'Widgets/customAppBar.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  _FavoritesState();

  var imageUrl =
      'https://t4.ftcdn.net/jpg/02/79/95/39/360_F_279953994_TmVqT7CQhWQJRLXev4oFmv8GIZTgJF1d.jpg';
  List favoritedIcons = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Favourites'),
      //     centerTitle: true,
      //     backgroundColor: Colors.blue.shade200),
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline,
              color: Colors.green.shade500,
            ),
            const Text("Favourites",
              style: TextStyle(
                  color: Colors.black
              ),),
          ],
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: ListView(children: [
        FutureBuilder(
          future: FireStoreCollections().fetchFavorites(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return Column(
                  children: List.generate(snapshot.data!.length, (index) {
                    if (favoritedIcons.length <= index) {
                      favoritedIcons.add(false);
                    }
                    for (var element in UserAuthentication.currentUser
                        .favorites) {
                      if (snapshot.data![index].houseId == element) {
                        favoritedIcons[index] = true;
                      }
                    }
                    return Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return HouseDetails(
                                  house: snapshot.data![index],
                                  user: snapshot.data![index].userId,
                                  imageUrl: imageUrl,
                                );
                              }));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  imageUrl,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 12, left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].price.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          "${snapshot.data![index]
                                              .address} ${snapshot.data![index]
                                              .area}"),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: OutlinedButton(
                                            onPressed: () {
                                              // openChatWithUser(
                                              //     userId: snapshot
                                              //         .data![index].userId);
                                            },
                                            child: Text('Chat')),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 12, right: 15),
                              child: InkWell(
                                  onTap: () {
                                    HouseFunctions().toggleFavorite(
                                        snapshot.data![index].houseId);
                                    setState(() {
                                      favoritedIcons[index] =
                                      !favoritedIcons[index];
                                    });
                                  },
                                  child: Icon(
                                    favoritedIcons[index]
                                        ? CupertinoIcons.heart_fill
                                        : CupertinoIcons.heart,
                                    color: favoritedIcons[index]
                                        ? Colors.red
                                        : null,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  ),
              );
            }else{
              // return const AlertDialog(
              //   actions: [
              //     LinearProgressIndicator()
              //   ],
              // );
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LoadShimmer(),
                  SizedBox(height: 5,),
                  LoadShimmer(),
                  SizedBox(height: 5,),
                  LoadShimmer(),
                  SizedBox(height: 5,),
                  LoadShimmer()
                ],
              );
              // return Expanded(
              //     child: ListView.builder(
              //       itemCount: 5,
              //         itemBuilder: (context, index) {
              //         return const LoadShimmer();
              //         })
             // );
            }
          },
        ),
      ]),
    );
  }
}
