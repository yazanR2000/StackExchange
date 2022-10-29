import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart' as u;

class AppDrawer extends StatefulWidget {
  AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  //only for testing:
  String imageURL = "https://cdn-icons-png.flaticon.com/512/149/149071.png";
  final u.User _user = u.User.getInstance();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              _user.userData['Full name'],
              style: TextStyle(fontSize: 24),
            ),
            decoration: BoxDecoration(color: Colors.black87),
            accountEmail: Text(
              FirebaseAuth.instance.currentUser!.email!,
            ),
            currentAccountPicture: Hero(
              tag: 'Full name',
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        title: Column(
                          children: [
                            Hero(
                              tag: 'Full name',
                              child: Image(
                                image:
                                    NetworkImage(_user.userData['User image']),
                              ),
                            ),
                          ],
                        ),
                      ); //Create item
                    }),
                  );
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_user.userData['User image']),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "My profile",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: const Icon(Icons.person),
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/profile', arguments: _user.userData.id);
            },
          ),
          ListTile(
            title: Text(
              "My questions",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: const Icon(Icons.my_library_books),
            onTap: () {
              Navigator.of(context).pushNamed('/my_questions');
            },
          ),
          ListTile(
            title: Text(
              "Logout",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: Icon(
              Icons.logout,
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
