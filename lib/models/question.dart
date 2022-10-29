import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import './user.dart' as u;
import './comment.dart';
import 'dart:io' as i;

class Question {
  final QueryDocumentSnapshot<Map<String, dynamic>> _question;
  Question(this._question);
  QueryDocumentSnapshot<Map<String, dynamic>> get question => _question;
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

  static Future addNewComment(Map<String, dynamic> details, String qId) async {
    if (details['images'].length == 0 && details['comment'] == "") {
      throw "Please add a text or image at least";
    }
    try {
      log("1");
      final List<XFile> images = details['images'];
      final List<String> downUrls = [];
      log("2");
      if (details['images'].length > 0) {
        final ref = FirebaseStorage.instance
            .ref()
            .child("Questions")
            .child(qId)
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
        log("3");
      }
      final u.User user = u.User.getInstance();
      log("${user.userData['Full name']}");
      log("4");

      log("${details['comment']}");
      await FirebaseFirestore.instance
          .collection("Comments")
          .doc(qId)
          .collection("Comments")
          .add({
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "userFullName": user.userData['Full name'],
        "date": DateTime.now().toLocal().toString(),
        "comment": details['comment'],
        "vote": 0,
        "images": downUrls,
        "userProfileImage" : user.userData['User image'],
      });
      log("5");
    } catch (err) {
      throw err;
    }
  }

  //only owner of the question can access these three methods
  static Future deleteQuestionFromOwner(QueryDocumentSnapshot question) async {
    try {
      await FirebaseFirestore.instance
          .runTransaction((Transaction myTransaction) async {
        myTransaction.delete(question.reference);
      });
      final u.User user = u.User.getInstance();
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(question['userId'])
          .update({
        "questions": user.userData['questions'] - 1,
      });
      await user.getUserData();
    } catch (err) {
      throw err;
    }
  }

  static Future closeQuestionFromOwner(
      QueryDocumentSnapshot question, QueryDocumentSnapshot comment) async {
    try {
      log("yazan");
      await FirebaseFirestore.instance
          .runTransaction((Transaction myTransaction) async {
        myTransaction.update(question.reference, {
          "solvedComment": comment.id,
        });
      });
      final u.User user = u.User.getInstance();
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(comment['userId'])
          .update({
        "solutions": user.userData['solutions'] + 1,
      });
      await user.getUserData();
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