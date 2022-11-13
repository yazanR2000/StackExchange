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
  // List<Widget> _pages = [
  //   HomePage(),
  //   MyQuestions(),
  //   MySaves(),
  //   StackOverflowScreen(),
  // ];
  int _current = 0;
  void _rebuild() {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, BoxConstraints constraints) => Scaffold(
        
        
        body: HomePage(),
        floatingActionButton: FloatingActionButton(
          //backgroundColor: Color(0xff2f3b47),
          onPressed: () {
            Navigator.of(context)
                .pushNamed("/add_new_question", arguments: _rebuild);
          },
          child: const Icon(Icons.add),
        ) ,
        // bottomNavigationBar: BottomNavigationBar(
        //   //fixedColor: Colors.black,
        //   selectedIconTheme: IconThemeData(
        //     color: Colors.black,
        //   ),
        //   unselectedIconTheme: IconThemeData(
        //     color: Colors.grey
        //   ),
        //   currentIndex: _current,
        //   onTap: (value){
        //     setState(() {
        //       _current = value;
        //     });
        //   },
        //   //type: BottomNavigationBarType.,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: "Home"
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.question_mark),
        //       label: "My questions"
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.bookmark),
        //       label: "Saves"
        //     ),
        //     BottomNavigationBarItem(
        //       icon: FaIcon(FontAwesomeIcons.stackOverflow),
        //       label: "Stackoverflow"
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
