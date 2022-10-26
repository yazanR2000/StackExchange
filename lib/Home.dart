import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stackexchange/Components/AddNewPost.dart';
import 'package:stackexchange/Components/Comment_component.dart';
import 'package:stackexchange/Components/Drawer.dart';
import 'package:stackexchange/Components/Question.dart';
import 'package:stackexchange/models/question.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool bookmark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: ((context) => AddNewPostComponent()));
          },
          child: Icon(Icons.add)),
      appBar: AppBar(),
      body: ListView(
        children: [
          QuestionComponent(),
          CommentComponent(
            isContainedImage: false,
          )
        ],
      ),
    );
  }
}
