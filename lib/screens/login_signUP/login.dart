import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stackexchange/models/google.dart';
import 'package:stackexchange/screens/login_signUP/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String screenRoute = "login";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController? emailController = TextEditingController();
TextEditingController? passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
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
        body: Form(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Welcome Back!",
                        style: TextStyle(fontSize: 35),
                        textAlign: TextAlign.start),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "Sign in to continue",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 45, left: 45),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50),
                          maximumSize: const Size(350, 50),
                        ),
                        onPressed: () async {
                          try {
                            var auth = await FirebaseAuth.instance;

                            UserCredential myUser =
                                await auth.signInWithEmailAndPassword(
                                    email: emailController!.text.trim(),
                                    password: passwordController!.text.trim());
                            emailController!.clear();
                            passwordController!.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("login successfully")));

                            // if (myUser != null) {
                            //   Navigator.pushReplacementNamed(
                            //       context, Homepage.screenRoute);
                            // }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "No user found for that email.")));
                            } else if (e.code == 'wrong-password') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Wrong password provided for that user.")));
                            }
                          }
                        },
                        child: Text(
                          "Login Now",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 50,
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
                            UserCredential googleUser =
                                await signInWithGoogle();
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
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: <Widget>[
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        TextButton(
                          child: const Text(
                            'Sign up',
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, SignUp.screenRoute);
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
