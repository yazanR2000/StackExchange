import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/home_provider.dart';
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
    return RefreshIndicator(
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
    );
  }
}
