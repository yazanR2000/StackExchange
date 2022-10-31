import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/question.dart';

class UserProblems extends StatefulWidget {
  final String _userId;
  final BoxConstraints _constraints;
  UserProblems(this._userId,this._constraints);

  @override
  State<UserProblems> createState() => _UserProblemsState();
}

class _UserProblemsState extends State<UserProblems> {
  void _rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                .where("userId", isEqualTo: widget._userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return SizedBox(
                  child: Center(
                    child: Text("There is no problems posted yet."),
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
                  return QuestionComponent(data[index], true, _rebuild);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
