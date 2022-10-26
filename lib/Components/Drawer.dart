import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  //only for testing:
  String imageURL = "https://cdn-icons-png.flaticon.com/512/149/149071.png";
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "Mohammed",
              style: TextStyle(fontSize: 24),
            ),
            decoration: BoxDecoration(color: Colors.black87),
            accountEmail: Text("test@test.com"),
            currentAccountPicture: Image(
              image: NetworkImage(imageURL),
            ),
          ),
          ListTile(
            title: Text("My questions"),
            trailing: const Icon(Icons.my_library_books),
            onTap: () {},
          ),
          ListTile(
            title: Text("Saved posts"),
            trailing: const Icon(Icons.bookmark),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            trailing: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
