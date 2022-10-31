import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stackexchange/widgets/Drawer.dart';
import 'package:stackexchange/widgets/home_questions.dart';
import '../widgets/question.dart';
import '../models/user.dart' as u;
import '../models/stack.dart' as s;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:developer';
import '../models/home_provider.dart';
import 'package:provider/provider.dart';
class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _rebuild(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(ctx, BoxConstraints constraints) =>  Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              FaIcon(
                size: 30,
                FontAwesomeIcons.accusoft,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Stack",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        drawer: AppDrawer(),
        body: RefreshIndicator(
          onRefresh: () async {
            _rebuild();
          },
          child: Consumer<HomeProvider>(
            builder:(context, value, child) => StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Questions").snapshots(),
              builder: (context, snapshot) {
                
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final data = snapshot.data!.docs;
                return HomeQuestions(data,_rebuild);
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/add_new_question",arguments: _rebuild);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
