import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stackexchange/screens/home.dart';
import 'package:stackexchange/screens/login_signUP/StartScreen.dart';
import '../models/user.dart' as u;
class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final u.User user = u.User.getInstance();

  void _reload(){
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 4)),
      builder: (context, snapshotSplash) {
        if (snapshotSplash.connectionState == ConnectionState.waiting) {
          return Splash();
        }
        return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, snapshotUser) {
              if (snapshotUser.hasData) {
                if (snapshotUser.data!.emailVerified) {
                  return FutureBuilder(
                    future: user.getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Scaffold(
                          body: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return Home();
                    },
                  );
                }
                return StartScreen(_reload);
              } else {
                return StartScreen(_reload);
              }
            });
      },
    );
  }
}
class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/splash2.gif'),
        )),
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage('images/logo-removebg.png'),
          //fit: BoxFit.fill,
        ),
      ),
    );
  }
}