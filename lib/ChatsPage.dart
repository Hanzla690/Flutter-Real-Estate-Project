import 'package:flutter/material.dart';
import 'package:flutter_project/ChatActivePage.dart';
import 'package:flutter_project/FireStoreCollections.dart';
import 'package:flutter_project/HomePage.dart';
import 'package:flutter_project/Widgets/bottom_nav_bar.dart';

import 'Widgets/customAppBar.dart';
import 'Widgets/loadShimmer.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        title: Row(
          children: [
            Icon(
              Icons.chat_outlined,
              color: Colors.green.shade500,
            ),
            const Text("Chats",
              style: TextStyle(
                  color: Colors.black
              ),),
          ],
        ),
        centerTitle: true,

      ),
      bottomNavigationBar: const BottomNavBar(),
      body: FutureBuilder(
        future: FireStoreCollections().fetchUsers(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Chat(
                                  user: snapshot.data![index],
                                )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10, left: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.green.shade100,
                          radius: 26,
                          child: Icon(Icons.person,
                            color: Colors.green.shade500,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data![index].username,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text('New Message'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          else{
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
          }
        },
      ),
    );
  }
}
