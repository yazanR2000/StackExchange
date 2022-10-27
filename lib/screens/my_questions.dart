import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/question.dart';

class MyQuestions extends StatelessWidget {
  MyQuestions({super.key});
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Questions")
            .where("userId", isEqualTo: uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("You didn't add any quetion"),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/add_new_question');
                  },
                  child: Text("Post a question"),
                ),
              ],
            );
          }
          final data = snapshot.hasData ? snapshot.data!.docs : [];
          return ListView.separated(
            padding: const EdgeInsets.all(15),
            reverse: true,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            itemBuilder: (context, index) {
              return QuestionComponent(data[index]);
            },
          );
        },
      ),
    );
  }
}
