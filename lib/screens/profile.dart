import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stackexchange/widgets/user_problems.dart';
import '../widgets/user_info.dart';
import '../widgets/user_statistic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
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
      color: const Color(0xff34B3F1),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff34B3F1),
          body: SingleChildScrollView(
            //padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    "Yazan Radaideh",
                    style: const TextStyle(color: Colors.white),
                  ),
                  leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                UserInfo("Yazan Radaideh",
                    "https://dl.memuplay.com/new_market/img/com.vicman.newprofilepic.icon.2022-06-07-21-33-07.png"),
                const SizedBox(
                  height: 20,
                ),
                UserSatistic(143, 41),
                const SizedBox(
                  height: 20,
                ),
                UserProblems(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/add_new_question");
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}