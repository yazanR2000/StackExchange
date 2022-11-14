import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stackexchange/firebase_options.dart';
import 'package:stackexchange/screens/NotificationsScreen.dart';
import 'package:stackexchange/screens/admin_screen.dart';
import 'package:stackexchange/screens/auth.dart';
import 'package:stackexchange/screens/chat.dart';
import 'package:stackexchange/screens/contact_Us.dart';
import 'package:stackexchange/screens/img2txt.dart';
import 'package:stackexchange/screens/login_signUP/Test.dart';
import 'package:stackexchange/screens/login_signUP/forgotPassword.dart';
import 'package:stackexchange/screens/my_questions.dart';
import 'package:stackexchange/screens/stackoverflow.dart';
import './screens/profile.dart';
import './screens/add_new_question.dart';
import 'screens/contact_Us.dart';
import 'widgets/edit_profile.dart';
import 'screens/login_signUP/StartScreen.dart';
import './screens/login_signUP/signup.dart';
import './screens/login_signUP/login.dart';
import './screens/home.dart';
import './screens/full_post.dart';
import './screens/CommentsSheet.dart';
import './models/user.dart' as u;
import 'package:provider/provider.dart';
import './models/home_provider.dart';
import './screens/saves.dart';
import './providers.dart/profile_provider.dart';

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
        ChangeNotifierProvider.value(
          value: ProfileProvider(),
        ),
      ],
      child: MaterialApp(
        title: "QCODE",
        debugShowCheckedModeBanner: false,
        //themeMode: ThemeMode.dark,

        theme: ThemeData(
          //primarySwatch: Colors.blue,
          fontFamily: "Poppins",
          brightness: Brightness.light,
          //scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff4B6587),
            // elevation: 0,
            // actionsIconTheme: IconThemeData(
            //   color: Colors.white,
            // ),
            // iconTheme: IconThemeData(
            //   color: Colors.white,
            // ),
            // titleTextStyle: TextStyle(
            //   color: Colors.white,
            //   fontSize: 20,
            //   fontWeight: FontWeight.bold,
            // ),
          ),
          // elevatedButtonTheme: ElevatedButtonThemeData(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: const Color(0xff34B3F1),
          //     elevation: 0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(100),
          //     ),
          //     foregroundColor: Colors.white,
          //   ),
          // ),
          // textButtonTheme: TextButtonThemeData(
          //   style: TextButton.styleFrom(
          //     elevation: 0,
          //     foregroundColor: Colors.black,
          //     textStyle: TextStyle(),
          //   ),
          // ),
          // outlinedButtonTheme: OutlinedButtonThemeData(
          //   style: OutlinedButton.styleFrom(
          //     elevation: 0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(100),
          //     ),
          //     foregroundColor: Colors.black,
          //     side: const BorderSide(color: Colors.black, width: 2),
          //   ),
          // ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xff4B6587),
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontWeight: FontWeight.bold,
              //color: Colors.blue,
              fontSize: 20,
            ),
            bodyText2: TextStyle(
              // fontWeight: FontWeight.bold,
              //color: Colors.grey,
              fontSize: 15,
            ),
          ),
        ),
        // darkTheme: ThemeData.dark(
        //   useMaterial3: true
        // ),

        home: Auth(),
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
          //'/StartScreen': (context) => StartScreen(),
          '/my_saves': (context) => MySaves(),
          '/stackoverflow': (context) => StackOverflowScreen(),
          '/NotificationsScreen': (context) => NotificationsScreen(),
          '/Contact_Us': (context) => Contact_Us(),
          '/ChatScreen': (context) => ChatScreen(),
          '/image_Too_text': (context) => image_To_text(),
          '/GetContact': (context) => GetContact(),
          testPage.screenRoute: (context) => testPage()
        },
      ),
    );
  }

  // handleAuthState() {
  //   final u.User user = u.User.getInstance();
  //   return FutureBuilder(
  //     future: Future.delayed(Duration(seconds: 4)),
  //     builder: (context, snapshotSplash) {
  //       if (snapshotSplash.connectionState == ConnectionState.waiting) {
  //         return Splash();
  //       }
  //       return StreamBuilder(
  //           stream: FirebaseAuth.instance.authStateChanges(),
  //           builder: (BuildContext context, snapshotUser) {
  //             if (snapshotUser.hasData) {
  //               if (snapshotUser.data!.emailVerified) {
  //                 return FutureBuilder(
  //                   future: user.getUserData(),
  //                   builder: (context, snapshot) {
  //                     if (snapshot.connectionState == ConnectionState.waiting) {
  //                       return Scaffold(
  //                         body: Center(
  //                           child: CircularProgressIndicator(),
  //                         ),
  //                       );
  //                     }
  //                     return Home();
  //                   },
  //                 );
  //               }
  //               //return StartScreen();
  //             } else {
  //               //return StartScreen();
  //             }
  //           });
  //     },
  //   );
  // }
}

// class Splash extends StatelessWidget {
//   const Splash({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//           fit: BoxFit.cover,
//           image: AssetImage('images/splash2.gif'),
//         )),
//         child: Image(
//           fit: BoxFit.cover,
//           image: AssetImage('images/logo-removebg.png'),
//           //fit: BoxFit.fill,
//         ),
//       ),
//     );
//   }
// }
//Determine if the user is authenticated.
