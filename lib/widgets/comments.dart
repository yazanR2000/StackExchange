import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Comment_component.dart';

class Comments extends StatefulWidget {
  Comments(this._question,this._rebuild);
  final QueryDocumentSnapshot _question;
  final Function _rebuild;
  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final CollectionReference _comments =
      FirebaseFirestore.instance.collection('Comments');

  final uid = FirebaseAuth.instance.currentUser!.uid;

  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _comments.doc(widget._question.id).collection('Comments').snapshots(),
        builder: (context, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (streamSnapshot.hasData) {
            final data = streamSnapshot.data!.docs;
            if (data.length == 0) {
              return const Center(
                child: Text("There's no comments"),
              );
            }
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              padding: EdgeInsets.only(bottom: 50),
              reverse: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: ((context, index) {
                return CommentComponent(
                    data[index], uid == widget._question['userId'], widget._question,widget._rebuild);
              }),
            );
          }
          return const Center(
            child: Text("There's no comments"),
          );
        });
  }
}
