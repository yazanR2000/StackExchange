//Singelton class
import 'package:image_picker/image_picker.dart';

import './question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io' as i;
import 'package:firebase_auth/firebase_auth.dart';

class User {
  static final User _user = User();
  User() {}
  static User getInstance() => _user;

  String? _uid;
  String? get uid => _uid;
  set uid(String? value) {
    _uid = value;
  }

  Future addNewQuestion(Map<String, dynamic> details) async {
    try {
      final String questionId = DateTime.now().toLocal().toString();
      final List<XFile> images = details['images'];
      final List<String> downUrls = [];
      if (details['images'].length > 0) {
        final ref = FirebaseStorage.instance
            .ref()
            .child("Questions")
            .child(questionId);
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
      }
      await FirebaseFirestore.instance
          .collection("Questions")
          .doc(questionId)
          .set({
        "type": details['type'],
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "questionTitle": details['title'],
        "description": details['description'],
        "images": downUrls,
        "date": DateTime.now().toLocal().toString()
      });
    } catch (err) {
      throw err;
    }
  }
}

/*
(Structure on firestore)
User Collection 
  UserId
    {
      "Full name" : String,
      "Phone number" : Number,
      "Profile image" : String => "image url from storage",
    }
*/