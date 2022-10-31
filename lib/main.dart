import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stackexchange/firebase_options.dart';
import 'package:stackexchange/screens/login_signUP/forgotPassword.dart';
import 'package:stackexchange/screens/my_questions.dart';
import './screens/profile.dart';
import './screens/add_new_question.dart';
import 'screens/login_signUP/StartScreen.dart';
import './screens/login_signUP/signup.dart';
import './screens/login_signUP/login.dart';
import './screens/home.dart';
import './screens/full_post.dart';
import './screens/CommentsSheet.dart';
import './models/user.dart' as u;
import 'package:provider/provider.dart';
import './models/home_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: HomeProvider(),
        ),
      ],
      child: MaterialApp(
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
            titleTextStyle: TextStyle(
                color: Colors.black,
                //fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff34B3F1),
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
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
            bodyText2: TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        home: handleAuthState(),
        routes: {
          "/profile": (context) => Profile(),
          "/add_new_question": (context) => AddNewQuestions(),
          '/sign_up': (context) => SignUp(),
          '/login': (context) => LoginPage(),
          '/FullPost': (context) => FullPost(),
          '/CommentSheet': (context) => CommentSheet(),
          '/home': (context) => Home(),
          'forgotPassword': (context) => forgotPassword(),
          '/my_questions': (context) => MyQuestions(),
          '/StartScreen': (context) => StartScreen()
        },
      ),
    );
  }

  handleAuthState() {
    final u.User user = u.User.getInstance();
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 4)),
      builder: (context, snapshotSplash) {
        if (snapshotSplash.connectionState == ConnectionState.waiting) {
          return Splash();
        }
        return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
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
              } else {
                return StartScreen();
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
        child: Image(
          image: AssetImage('images/splash.gif'),
          //fit: BoxFit.fill,
        ),
      ),
    );
  }
}
//Determine if the user is authenticated.
