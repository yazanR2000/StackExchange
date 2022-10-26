import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stackexchange/screens/StartScreen.dart';
import 'package:stackexchange/screens/Test.dart';
import 'package:stackexchange/screens/login_signUP/login.dart';
import 'package:stackexchange/screens/login_signUP/signup.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.screenRoute: (context) => LoginPage(),
        SignUp.screenRoute: (context) => SignUp(),
        StartScreen.screenRoute: (context) => StartScreen(),
        testPage.screenRoute: (context) => testPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "OpenSans",
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff034ef7),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            foregroundColor: Colors.white,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            elevation: 0,
            foregroundColor: Colors.black,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            foregroundColor: Colors.black,
            side: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xff34B3F1),
        ),
      ),
      home: handleAuthState(),
    );
  }
}

//Determine if the user is authenticated.
handleAuthState() {
  return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return const testPage();
        } else {
          return const StartScreen();
        }
      });
}
