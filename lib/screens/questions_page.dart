import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/home_provider.dart';
import '../widgets/Drawer.dart';
import '../widgets/home_questions.dart';
import '../widgets/waiting_questions.dart';

class QuetionsPage extends StatefulWidget {
  const QuetionsPage({super.key});

  @override
  State<QuetionsPage> createState() => _QuetionsPageState();
}

class _QuetionsPageState extends State<QuetionsPage> {
  void _rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          if (FirebaseAuth.instance.currentUser!.email == 'qcode2022@gmail.com')
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
        ],
        title: Text(
          "Feeds",
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _rebuild();
        },
        child: Consumer<HomeProvider>(
          builder: (context, value, child) => StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Questions")
                .orderBy('date', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ShimmerWaiting();
              }
              final data = snapshot.data!.docs;
              return HomeQuestions(data, _rebuild);
            },
          ),
        ),
      ),
    );
  }
}
