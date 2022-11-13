import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stackexchange/widgets/waiting_questions.dart';

import 'Comment_component.dart';

class Comments extends StatefulWidget {
  Comments(this._question, this._rebuild);
  final QueryDocumentSnapshot _question;
  final Function _rebuild;
  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final CollectionReference _comments =
      FirebaseFirestore.instance.collection('Comments');

  final uid = FirebaseAuth.instance.currentUser!.uid;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _questionComments = [];
  void _pinSolvedComment() {
    String solvedCommentId = widget._question['solvedComment'];
    if (solvedCommentId != "null") {
      for (int i = 0; i < _questionComments.length; i++) {
        if (solvedCommentId == _questionComments[i].id){
          final temp = _questionComments[i];
          final firstIndex = _questionComments[0];
          _questionComments[i] = firstIndex;
          _questionComments[0] = temp;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _comments
            .doc(widget._question.id)
            .collection('Comments')
            .orderBy('date')
            .snapshots(),
        builder: (context, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (streamSnapshot.hasData) {
            _questionComments = streamSnapshot.data!.docs;
            if (_questionComments.length == 0) {
              return const Center(
                child: Text("There's no comments"),
              );
            }
            _pinSolvedComment();
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
              thickness: 2,
              height: 2,
              //color: Colors.blueGrey.shade50,
            ),
              padding: EdgeInsets.only(bottom: 50),
              //reverse: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _questionComments.length,
              itemBuilder: ((context, index) {
                return CommentComponent(
                  _questionComments[index],
                  uid == widget._question['userId'],
                  widget._question,
                  widget._rebuild,
                );
              }),
            );
          }
          return const Center(
            child: Text("There's no comments"),
          );
        });
  }
}
