//Singelton class
import 'dart:developer';

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

  Map<String, dynamic>? _userInfo;

  set UserInfo(Map<String, dynamic> value) {
    _userInfo = value;
  }

  DocumentSnapshot? _userData;
  DocumentSnapshot get userData => _userData!;
  set userData(DocumentSnapshot value) {
    _userData = value;
  }

  Future getUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final data =
          await FirebaseFirestore.instance.collection("Users").doc(uid).get();

      _userData = data;
    } catch (err) {
      throw err;
    }
  }

  Future addUserInfo() async {
    if (_userInfo == null) {
      return;
    }
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("Users").child(userId);
      String? imageUrl;
      if (_userInfo!['image'].isNotEmpty) {
        await ref.putFile(i.File(_userInfo!['image']));
        imageUrl = await ref.getDownloadURL();
      }
      await FirebaseFirestore.instance.collection("Users").doc(userId).set({
        "User image": imageUrl == null
            ? "https://cdn.icon-icons.com/icons2/2643/PNG/512/male_boy_person_people_avatar_icon_159358.png"
            : imageUrl,
        'User Email': _userInfo!['User Email'],
        "Full name": _userInfo!['Full name'],
        "Phone number": _userInfo!['Phone number'],
        "questions": 0,
        "solutions": 0,
      });
    } catch (err) {
      throw err;
    }
  }

  // Future contactus() async {
  //   if (_userInfo == null) {
  //     return;
  //   }

  //   try {
  //     final userId = FirebaseAuth.instance.currentUser!.uid;
  //     await FirebaseFirestore.instance
  //         .collection("Contact Us")
  //         .doc(userId)
  //         .set({
  //       'email': _userInfo!['email'],
  //       "name": _userInfo!['name'],
  //       "massege": _userInfo!['massege'],
  //     });
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future addToFavorite(
      QueryDocumentSnapshot question, bool isAddOrRemove) async {
    try {
      if (isAddOrRemove) {
        await FirebaseFirestore.instance
            .collection('Saves')
            .doc(_userData!.id)
            .collection('Saves')
            .doc(question.id)
            .set(
              question.data() as Map<String, dynamic>,
            );
      } else {
        await FirebaseFirestore.instance
            .collection('Saves')
            .doc(_userData!.id)
            .collection('Saves')
            .doc(question.id)
            .delete();
      }
    } catch (err) {
      throw err;
    }
  }

  Future addNewQuestion(Map<String, dynamic> details) async {
    try {
      final String questionId = DateTime.now().toLocal().toString();
      final List<XFile> images = details['images'];
      final List<String> downUrls = [];
      if (details['images'].length > 0) {
        await Future.wait(
          images.map((e) async {
            Reference ref = FirebaseStorage.instance
                .ref()
                .child("Questions")
                .child(questionId)
                .child(DateTime.now().toLocal().toString());
            final UploadTask uploadTask = ref.putFile(i.File(e.path));
            String? dowurl;
            await uploadTask.whenComplete(() async {
              dowurl = await ref.getDownloadURL();
            });
            downUrls.add(dowurl!);
          }),
        );
      }
      log("yazan");
      await FirebaseFirestore.instance
          .collection("Questions")
          .doc(questionId)
          .set({
        "type": _getSyntax(details['type']),
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "userFullName": _userData!['Full name'],
        "userImageUrl": _userData!['User image'],
        "questionTitle": details['title'],
        "description": details['description'],
        "images": downUrls,
        "date": DateTime.now().toLocal().toString(),
        "solvedComment": "null",
        "code" : details['code']
      });
      log("yazan1");
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(_userData!.id)
          .update({"questions": _userData!['questions'] + 1});
      log("yazan2");
      await getUserData();
      log("yazan3");
    } catch (err) {
      throw err;
    }
  }
   String _getSyntax(String type) {
    switch (type) {
      case "Flutter":
        {
          return "dart";
        }
      case "C++":
        {
          return "cpp";
        }
      case "Java":
        {
          return "java";
        }
      case "C#":
        {
          return "csharp";
        }
      case "IOS":
        {
          return "swift";
        }
      case "Desktop":
        {
          return "c#";
        }
      case "React native":
        {
          return "javascript";
        }
      case "Others":
        {
          return "dart";
        }
    }
    return "Syntax.C";
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