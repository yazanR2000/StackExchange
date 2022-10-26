import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final QueryDocumentSnapshot<Map<String, dynamic>> _comment;
  Comment(this._comment);
  //update requests
  Future upVote() async {
    try {
      int upVote = _comment['Vote'];
      await FirebaseFirestore.instance
          .runTransaction((Transaction myTransaction) async {
        myTransaction.update(
          _comment.reference,
          {"Vote": ++upVote},
        );
      });
    } catch (err) {
      throw err;
    }
  }

  Future downVote() async {
    try {
      int upVote = _comment['Vote'];
      await FirebaseFirestore.instance
          .runTransaction((Transaction myTransaction) async {
        myTransaction.update(
          _comment.reference,
          {"Vote": --upVote},
        );
      });
    } catch (err) {
      throw err;
    }
  }
  //only owner of question can access this method
  //Future closedComment() async {} // mean that this comment solve the problem
}

/*
(Structure on firestore)
Comments Collection
  QuestionId
    Comments Collection
    [CommentId]
      {
          "userId" : String,
          "userImage" : String,
          "date" : String,
          "comment" : String,
          "vote" : Number
          "image" : [String],
      }
*/