import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("https://images.unsplash.com/photo-1602472097151-72eeec7a3185?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTl8fHxlbnwwfHx8fHw%3D")
              ),
              color: Colors.teal,
            ),
              accountName: const Text("Malik Riaz",
              style: TextStyle(
                fontSize: 20.0,
              )),
              accountEmail: const Text("messi@barca.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("assets/malikriaz.jpg",
                width: 90,
                height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListTile(
            selectedTileColor: Colors.green.shade200,
            leading: Icon(
              Icons.home,
              color: Colors.green.shade500,
            ),
            title: const Text("Home"),
             onTap: () {},
          ),
          ListTile(
            selectedTileColor: Colors.teal.shade300,
            leading: Icon(
                Icons.favorite_outline,
              color: Colors.green.shade500,
            ),
            title: const Text("Favourites"),
            onTap: () {},
          ),
          ListTile(
            selectedTileColor: Colors.teal.shade300,
            leading: Icon(
                Icons.chat_outlined,
              color: Colors.green.shade500,
            ),
            title: const Text("Chats"),
          ),
          ListTile(
            selectedTileColor: Colors.teal.shade300,
            leading: Icon(
                Icons.add_circle_outline,
              color: Colors.green.shade500,
            ),
            title: const Text("Post Property Ad")
          ),
          // ListTile(
          //   selectedTileColor: Colors.teal.shade300,
          //   leading: const Icon(
          //       Icons.people_alt_outlined
          //   ),
          //   title: const Text("Teams"),
          //   onTap: () => print("teams\n"),
          // ),
          // ListTile(
          //   selectedTileColor: Colors.teal.shade300,
          //   leading: const Icon(
          //       Icons.settings_accessibility_outlined
          //   ),
          //   title: const Text("Standings"),
          //   onTap: () => print("standings\n"),
          //)
        ],
      ),
    );
  }
}
