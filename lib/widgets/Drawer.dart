import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  _user.userData['Full name'],
                  style: TextStyle(fontSize: 24),
                ),
                decoration: BoxDecoration(color: Color(0xff2f3b47)),
                accountEmail: Text(
                  FirebaseAuth.instance.currentUser!.email!,
                ),
                currentAccountPicture: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: ((context) {
                        return Dialog(
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InteractiveViewer(
                                child: Container(
                                  height: constraints.maxHeight * 0.9,
                                  child: Image(
                                    image: NetworkImage(
                                        _user.userData['User image']),
                                  ),
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
                  "My Saves",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                trailing: const Icon(Icons.bookmark),
                onTap: () {
                  Navigator.of(context).pushNamed('/my_saves');
                },
              ),
              ListTile(
                title: Text(
                  "Search on Stackoverflow",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                trailing: const FaIcon(FontAwesomeIcons.stackOverflow),
                onTap: () {
                  Navigator.of(context).pushNamed('/stackoverflow');
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
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () async {
                        await Navigator.of(context).pushNamed('/Contact_Us');
                      },
                      title: Text(
                        "Contact us",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: Icon(Icons.contact_support_outlined),
                    ),
                    ListTile(
                      onTap: () {},
                      title: Text(
                        "See our guide",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      //trailing: FaIcon(FontAwesomeIcons.how),
                    ),
                    // SizedBox(
                    //   height: constraints.maxHeight * 0.1,
                    //   child: VerticalDivider(
                    //     indent: 30,
                    //     endIndent: 10,
                    //     color: Colors.black,
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
