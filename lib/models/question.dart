import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import './comment.dart';
import 'dart:io' as i;

class Question {
  final QueryDocumentSnapshot<Map<String, dynamic>> _question;
  Question(this._question);
  final List<Comment> _comments = [];
  List<Comment> get comment => _comments;
  void addComments(List<QueryDocumentSnapshot<Map<String, dynamic>>> comments) {
    _comments.clear();
    comments.forEach((element) {
      _comments.add(
        Comment(element),
      );
    });
  }

  Future addNewComment(Map<String, dynamic> details) async {
    try {
      final List<XFile> images = details['images'];
      final List<String> downUrls = [];
      final ref = FirebaseStorage.instance
          .ref()
          .child("Questions")
          .child(_question.id)
          .child("Comments");
      await Future.wait(
        images.map((e) async {
          final UploadTask uploadTask = ref.putFile(i.File(e.path));
          String? dowurl;
          await uploadTask.whenComplete(() async {
            dowurl = await ref.getDownloadURL();
          });
          downUrls.add(dowurl!);
        }),
      );
      await FirebaseFirestore.instance
          .collection("Comments")
          .doc(_question.id)
          .collection("Comments")
          .add({
        "userId": details['userId'],
        "userImage": details['userImage'],
        "date": details['date'],
        "comment": details['comment'],
        "vote": 0,
        "images": downUrls,
      });
    } catch (err) {
      throw err;
    }
  }

  //only owner of the question can access these three methods
  Future deleteQuestionFromOwner() async {
    try {
      await FirebaseFirestore.instance
          .runTransaction((Transaction myTransaction) async {
        myTransaction.delete(_question.reference);
      });
    } catch (err) {
      throw err;
    }
  }

  Future closeQuestionFromOwner(String commentId) async {
    try {
      await FirebaseFirestore.instance
          .runTransaction((Transaction myTransaction) async {
        myTransaction.update(_question.reference, {
          "isClosed": commentId,
        });
      });
    } catch (err) {
      throw err;
    }
  }

  Future editQuestionFromOwner(Map<String, dynamic> details) async {
    try {
      await FirebaseFirestore.instance
          .runTransaction((Transaction myTransaction) async {
        myTransaction.update(_question.reference, details);
      });
    } catch (err) {
      throw err;
    }
  }
}

// .collection("Questions").where("userId" , isEqua : userId);
/*

(Structure on firestore)
Questions Collection
  QuestionId
    {
      "type" : "flutter",
      "userId" : String,
      "userImage" : String,
      "userFullname" : String,
      "questionTitle" : String ({80 - 100}) => "we will user this for searching",
      "description" : String,
      "image" : [String],
      "date" : String => We will use this to check if it's new or not
      "isClosed" : Comment id - the comment that closed this question,
    }
*/