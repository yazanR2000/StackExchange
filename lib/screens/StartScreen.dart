import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stackexchange/models/google.dart';
import 'package:stackexchange/screens/login_signUP/login.dart';
import 'package:stackexchange/screens/login_signUP/signup.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});
  static const String screenRoute = "StartScreen";

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 10,
          title: Row(
            children: [
              FaIcon(
                size: 30,
                FontAwesomeIcons.accusoft,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Stack",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 350,
                  width: double.infinity,
                  child: Image(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "images/logo-removebg-preview.png",
                    ),
                  ),
                ),
                Text(
                  "Hello!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                  ),
                ),
                Text(
                  "Welcome to our Platform",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 50),
                        maximumSize: const Size(150, 50),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, LoginPage.screenRoute);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 50),
                        maximumSize: const Size(150, 50),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, SignUp.screenRoute);
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text("Or via social media"),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xff2D75E8),
                        ),
                        child: FaIcon(
                          size: 18,
                          FontAwesomeIcons.facebookF,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        UserCredential googleUser = await signInWithGoogle();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xffe54545),
                        ),
                        child: FaIcon(
                          size: 18,
                          FontAwesomeIcons.google,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xff3252A7),
                        ),
                        child: FaIcon(
                          size: 18,
                          FontAwesomeIcons.linkedinIn,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
