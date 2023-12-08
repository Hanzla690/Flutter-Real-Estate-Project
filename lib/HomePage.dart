import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_project/ChatActivePage.dart';
import 'package:flutter_project/ChatsPage.dart';
import 'package:flutter_project/CreateHousePostPage.dart';
import 'package:flutter_project/FavoritesPage.dart';
import 'package:flutter_project/FireStoreCollections.dart';
import 'package:flutter_project/HouseDetailsPage.dart';
import 'package:flutter_project/Models/UserModel.dart';
import 'package:flutter_project/User%20Authentication/LoginPage.dart';
import 'package:flutter_project/ProfilePage.dart';
import 'package:flutter_project/User%20Authentication/SignUpPage.dart';
import 'package:flutter_project/User%20Authentication/UserAuthentication.dart';
import 'package:flutter_project/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade200),
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  final String title = 'App';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var imageUrl =
      'https://t4.ftcdn.net/jpg/02/79/95/39/360_F_279953994_TmVqT7CQhWQJRLXev4oFmv8GIZTgJF1d.jpg';
  var cardNames = ['Home', 'Rent', 'Plots', 'Commercial'];
  var cardItems = [
    '3 Marla',
    '5 Marla',
    '7 Marla',
    '10 Marla',
    '1 Kanal',
    '2 Kanal'
  ];
  List<IconData> cardIcons = [
    Icons.home,
    Icons.business,
    Icons.location_city,
    Icons.store
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: Text(widget.title),
      ),
      bottomNavigationBar: CustomBottomAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              width: 390,
              height: 255,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey,
                    )
                  ]),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Browse Properties',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.house_outlined),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Houses'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.location_on_outlined),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Plots'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.store_outlined),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Commercial'),
                            ],
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: GridView.count(
                            crossAxisCount: 3,
                            childAspectRatio: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children: List.generate(cardItems.length, (index) {
                              return Container(
                                width: 40,
                                height: 20,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: .5,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  cardItems[index],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              );
                            })),
                      ),
                    ),
                  ]),
            ),
            const SizedBox(height: 15),
            FutureBuilder(
              future: FireStoreCollections().fetchHouses("Rent"),
              builder: (context, snapshot) {
                return Column(
                    children: List.generate(snapshot.data!.length, (index) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data![index].price.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        "${snapshot.data![index].address} ${snapshot.data![index].area}"),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25),
                                      child: OutlinedButton(
                                          onPressed: () {
                                            openChatWithUser(
                                                userId: snapshot
                                                    .data![index].userId);
                                          },
                                          child: Text('Chat')),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12, right: 15),
                            child: InkWell(
                                onTap: () {}, child: Icon(Icons.favorite)),
                          ),
                        ],
                      ),
                    ),
                  );
                }));
              },
            ),
          ],
        ),
      ),
    );
  }

  openChatWithUser({userId}) async {
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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Chat(user: user)));
    }
  }
}

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
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => MyHomePage())));
                },
                child: Column(
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
                child: Column(
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
                        MaterialPageRoute(builder: (context) => CreatePost()));
                  },
                  child: Icon(Icons.add))),
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Favorites())));
                },
                child: Column(
                  children: [
                    Icon(Icons.favorite),
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
                child: Column(
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
