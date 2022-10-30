import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer';

Future signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth!.accessToken,
      idToken: googleAuth.idToken,
    );

    final user = await FirebaseAuth.instance.signInWithCredential(credential);
    final nowDate = DateTime.now();
    final creationDate = user.user!.metadata.creationTime;
    if (nowDate.difference(creationDate!).inSeconds < 10) {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection("Users").doc(userId).set({
        "Full name": googleUser!.displayName,
        "Phone number": "07xxxxx",
        "User image": googleUser.photoUrl != null
            ? googleUser.photoUrl
            : "https://cdn.icon-icons.com/icons2/2643/PNG/512/male_boy_person_people_avatar_icon_159358.png",
        "questions": 0,
        "solutions": 0,
      });
    }
  } catch (err) {
    throw err;
  }
}
