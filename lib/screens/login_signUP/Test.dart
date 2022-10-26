import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class testPage extends StatefulWidget {
  const testPage({super.key});
  static const String screenRoute = "test";

  @override
  State<testPage> createState() => _testPageState();
}

class _testPageState extends State<testPage> {
  Future signOut() async {
    var result = await FirebaseAuth.instance.signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();
    // Navigator.pushReplacementNamed(context, StartScreen.screenRoute);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  signOut();
                });
              },
              icon: Icon(Icons.dangerous))
        ],
      ),
      body: Center(child: Image.asset("images/logo-removebg-preview.png")),
    );
  }
}
