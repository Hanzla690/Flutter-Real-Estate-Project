import 'package:flutter/material.dart';
import 'CreateHousePostPage.dart';
import 'FireStoreCollections.dart';
import 'HouseDetailsPage.dart';
import 'Models/UserModel.dart';
import 'User Authentication/UserAuthentication.dart';
import 'Widgets/bottom_nav_bar.dart';
import 'Widgets/loadShimmer.dart';

class MyAdsPage extends StatefulWidget {
  const MyAdsPage({Key? key}) : super(key: key);

  @override
  State<MyAdsPage> createState() => _MyAdsPageState();
}

class _MyAdsPageState extends State<MyAdsPage> {
  var imageUrl =
      'https://www.google.com/url?sa=i&url=https%3A%2F%2Ftwitter.com%2Flahoreqalandars%2Fstatus%2F1623700511034859526&psig=AOvVaw0id27dpTtXTJTeg5yOPtKk&ust=1702902885165000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCNCOi-G9loMDFQAAAAAdAAAAABAI';
  UserModel user = UserAuthentication.currentUser;
 // int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App'),
        backgroundColor: Colors.blue.shade200,
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView(
          children: [
            FutureBuilder(
            future: FireStoreCollections().fetchHouses(userID: user.id, searchMode: false),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: List.generate(snapshot.data!.length, (index) {
                    return Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return HouseDetails(
                                house: snapshot.data![index],
                                user: snapshot.data![index].userId,
                                imageUrl: imageUrl,
                              );
                            }),
                          );
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
                                  padding:
                                  const EdgeInsets.only(top: 12, left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${snapshot.data![index].price}', // Cast to String using '${}'
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${snapshot.data![index].address} ${snapshot.data![index].area}",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(100, 25),
                                        side: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CreatePost(
                                              editMode: true,
                                              house: snapshot.data![index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Edit",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(100, 25),
                                        side: const BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                              const Text("Delete Confirmation"),
                                              content: const Text(
                                                  "Are you sure you want to delete this Ad?"),
                                              actions: [
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    side: const BorderSide(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    await FireStoreCollections()
                                                        .deleteHouseAd(
                                                        snapshot.data![index]
                                                            .houseId);
                                                    setState(() {});
                                                  },
                                                  child: const Text(
                                                    "Yes",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    side: const BorderSide(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              } else {
                // return const LinearProgressIndicator();
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
              }
            },
          ),
      ]
        ),
      ),
    );
  }

}