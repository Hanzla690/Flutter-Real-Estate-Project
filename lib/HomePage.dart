import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_project/ChatActivePage.dart';
import 'package:flutter_project/ChatsPage.dart';
import 'package:flutter_project/CreateHousePostPage.dart';
import 'package:flutter_project/DetailsPage.dart';
import 'package:flutter_project/FavoritesPage.dart';
import 'package:flutter_project/FireStoreCollections.dart';
import 'package:flutter_project/HouseDetailsPage.dart';
import 'package:flutter_project/HouseFunctions.dart';
import 'package:flutter_project/Models/HouseModel.dart';
import 'package:flutter_project/Models/UserModel.dart';
import 'package:flutter_project/User%20Authentication/LoginPage.dart';
import 'package:flutter_project/ProfilePage.dart';
import 'package:flutter_project/User%20Authentication/UserAuthentication.dart';
import 'package:flutter_project/Widgets/bottom_nav_bar.dart';
import 'package:flutter_project/Widgets/drawer.dart';
import 'package:flutter_project/Widgets/search_field.dart';
import 'package:flutter_project/Widgets/select_cat.dart';
import 'package:flutter_project/Widgets/suggestion_list.dart';
import 'package:flutter_project/firebase_options.dart';
import 'package:flutter_project/splashscreen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'Widgets/customAppBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 // await MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apna Ghar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade200),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    scrollBehavior: const MaterialScrollBehavior().copyWith(
    dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},)
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
  bool searchModeValue = false;
  String propertyType = "House";
  String searchItem = "";
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
  List favoritedIcons = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Colors.green.shade500,
            ),
            const Text("Lahore, Pakistan",
              style: TextStyle(
                  color: Colors.black
              ),),
          ],
        ),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const DetailsPage()),
                );              },
              icon: const Icon(Icons.notifications,
                  color: Colors.green))
        ],
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavBar(),
      drawer: const NavBar(),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              const SizedBox(height: 8,),
              const SearchField(),
              const SizedBox(height: 8,),
              CarouselSlider(
                  items: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: const DecorationImage(
                          image: AssetImage("assets/cover-image-4-1.jpg"),
                           fit: BoxFit.cover
                           // image: NetworkImage("https://media.istockphoto.com/id/1409298953/photo/real-estate-agents-shake-hands-after-the-signing-of-the-contract-agreement-is-complete.jpg?s=1024x1024&w=is&k=20&c=Q7y-IUDhsXhiKKDPopD1ZRHRvkeunhledaJ2iMRdEr8="))
                      ),
                        borderRadius: BorderRadius.circular(25)
                      )
                    ),

                    Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            image: const DecorationImage(
                                image: AssetImage("assets/pexels-binyamin-mellish-186077.jpg"),
                                fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.circular(25)
                        )
                    ),

                    Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            image: const DecorationImage(
                                image: AssetImage("assets/sell-property-in-india.jpg"),
                                fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.circular(25)
                        )
                    )
                  ],
                  options: CarouselOptions(
                    height: 180,
                    aspectRatio: 16/8,
                    viewportFraction: 0.8,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration: const Duration(milliseconds: 500),
                    enlargeCenterPage: true,
                    enlargeFactor: 0.5
                  )
              ),

              Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                width: 390,
                height: 255,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.grey,
                      )
                    ]
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Browse Properties',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SelectCategory(),
                       const SizedBox(height: 7),
                     // SuggestionList("Recommended for you..", HouseModel.data),
                       const SizedBox(height: 10,),
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
                                  width: 30,
                                  height: 18,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: .5,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    cardItems[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                    color: Colors.green.shade500),
                                  )),
                                );
                              })),
                        ),
                      ),
                    ]),
              ),
               const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder(
                  future: FireStoreCollections().fetchHouses(searchMode: searchModeValue, searchItem: searchItem, propertyType: propertyType),
                  builder: (context, snapshot) {
                    return Column(
                        children: List.generate(snapshot.data!.length, (index) {
                          if(favoritedIcons.length <= index){
                            favoritedIcons.add(false);
                          }
                          for(var element in UserAuthentication.currentUser.favorites){
                            if(snapshot.data![index].houseId == element){
                              favoritedIcons[index] = true;
                            }
                          }
                      return Container(
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) {
                            //   return HouseDetails(
                            //     house: snapshot.data![index],
                            //     user: snapshot.data![index].userId,
                            //     imageUrl: imageUrl,
                            //   );
                            // }));
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=> const DetailsPage()));
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
                                    padding: const EdgeInsets.only(top: 12, left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].price.toString(),
                                          style: const TextStyle(
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
                                              child: const Text('Chat')),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12, right: 15),
                                child: InkWell(
                                    onTap: () {
                                      HouseFunctions().toggleFavorite(
                                          snapshot.data![index].houseId);
                                      setState(() {
                                        favoritedIcons[index] = !favoritedIcons[index];
                                      });
                                    },
                                    child: Icon(
                                      favoritedIcons[index]
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: favoritedIcons[index] ? Colors.red : null,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      );
                    }));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  openChatWithUser({userId}) async {
    if (userId == UserAuthentication.currentUser.id) {
      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pop(context);
          });
          return AlertDialog(
            content: const Text(
              'This ad was posted by this account, so cannot chat with yourself',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
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