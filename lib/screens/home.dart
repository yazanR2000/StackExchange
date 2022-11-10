import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stackexchange/screens/login_signUP/Test.dart';
import 'package:stackexchange/screens/my_questions.dart';
import 'package:stackexchange/screens/questions_page.dart';
import 'package:stackexchange/screens/saves.dart';
import 'package:stackexchange/widgets/Drawer.dart';
import 'package:stackexchange/widgets/home_questions.dart';
import '../widgets/question.dart';
import '../models/user.dart' as u;
import '../models/stack.dart' as s;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:developer';
import '../models/home_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/waiting_questions.dart';
import 'stackoverflow.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _pages = [
    QuetionsPage(),
    MyQuestions(),
    MySaves(),
    StackOverflowScreen(),
  ];
  int _current = 0;
  void _rebuild() {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, BoxConstraints constraints) => Scaffold(
        appBar: AppBar(
          actions: [
            if (FirebaseAuth.instance.currentUser!.email ==
                'qcode2022@gmail.com')
              MaterialButton(
                onPressed: (() {
                  Navigator.of(context).pushNamed('/GetContact');
                }),
                child: Icon(
                  Icons.contact_mail,
                  color: Colors.white,
                ),
              ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/NotificationsScreen');
              },
              icon: Icon(
                Icons.notifications,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(testPage.screenRoute);
              },
              icon: Icon(
                Icons.notifications,
              ),
            )
          ],
          title: Text(
            "Feeds",
          ),
        ),
        drawer: AppDrawer(),
        body: _pages[_current],
        floatingActionButton: _current == 0 ? FloatingActionButton(
          backgroundColor: Color(0xff2f3b47),
          onPressed: () {
            Navigator.of(context)
                .pushNamed("/add_new_question", arguments: _rebuild);
          },
          child: const Icon(Icons.add),
        ) : SizedBox(),
        bottomNavigationBar: BottomNavigationBar(
          //fixedColor: Colors.black,
          selectedIconTheme: IconThemeData(
            color: Colors.black,
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.grey
          ),
          currentIndex: _current,
          onTap: (value){
            setState(() {
              _current = value;
            });
          },
          //type: BottomNavigationBarType.,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.question_mark),
              label: "My questions"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: "Saves"
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.stackOverflow),
              label: "Stackoverflow"
            ),
          ],
        ),
      ),
    );
  }
}
