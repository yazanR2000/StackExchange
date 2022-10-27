import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/question.dart';

class UserProblems extends StatelessWidget {
  final String _userId;
  UserProblems(this._userId);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 520),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Problems",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Questions")
                .where("userId", isEqualTo: _userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return const SizedBox(
                  height: 400,
                  child: Center(
                    child: Text("Yazan dosn't post any problem yet"),
                  ),
                );
              }
              final data = snapshot.hasData ? snapshot.data!.docs : [];
              return ListView.separated(
                reverse: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemBuilder: (context, index) {
                  return QuestionComponent(data[index],true);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
