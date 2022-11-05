import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stackexchange/widgets/user_problems.dart';
import '../widgets/user_info.dart';
import '../widgets/user_statistic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DocumentSnapshot? _userData;

  Future _getUserInfo(String userId) async {
    try {
      _userData = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .get();
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)!.settings.arguments as String;
    return Container(
      color: const Color(0xff2f3b47),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (p0, constraints) => Scaffold(
            backgroundColor: const Color(0xff2f3b47),
            body: FutureBuilder(
              future: _getUserInfo(userId),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SingleChildScrollView(
                  //padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          _userData!['Full name'],
                          style: const TextStyle(color: Colors.white),
                        ),
                        leading: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                        trailing: TextButton(
                          child: Text(
                            "Contact",
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Contact'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        ListTile(
                                          dense: true,
                                          leading: Icon(Icons.call),
                                          title: Text(''),
                                        ),
                                        ListTile(
                                          dense: true,
                                          leading: Icon(Icons.email),
                                          title: Text(''),
                                        ),
                                        ListTile(
                                          dense: true,
                                          leading: Icon(Icons.email),
                                          title: Text('DirectMessage'),
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Back'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      UserInfo(
                        _userData!['Full name'],
                        _userData!['User image'],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      UserSatistic(
                        _userData!['questions'],
                        _userData!['solutions'],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      UserProblems(userId, constraints),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
