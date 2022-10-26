import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stackexchange/screens/Test.dart';
import 'package:stackexchange/screens/login_signUP/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  static const String screenRoute = "SignUp";
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  File? _image;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this._image = imageTemporary;
    });
  }

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
                    Text("Welcome !",
                        style: TextStyle(fontSize: 35),
                        textAlign: TextAlign.start),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "Sign up to continue",
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
                        controller: fullnameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: phoneNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number (optional)',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 45, left: 45),
                    //   child: ElevatedButton.icon(
                    //     icon: const Icon(
                    //         CupertinoIcons.photo_fill_on_rectangle_fill),
                    //     onPressed: () {
                    //       getImage();
                    //     },
                    //     label: const Text(
                    //       "Upload your Photo",
                    //     ),
                    //   ),
                    // ),
                    // _image != null
                    //     ? Image.file(
                    //         _image!,
                    //         width: 250,
                    //         height: 250,
                    //         fit: BoxFit.cover,
                    //       )
                    //     : Image.asset("images/person.png"),
                    SizedBox(
                      height: 40,
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
                            var auth = FirebaseAuth.instance;

                            UserCredential myUser =
                                await auth.createUserWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                            emailController.clear();
                            passwordController.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("added successfully")));
                            if (myUser != null) {
                              final userId =
                                  FirebaseAuth.instance.currentUser!.uid;
                              await FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(userId)
                                  .set({
                                "Full name": fullnameController.text,
                                "Phone number": phoneNumberController.text,
                              });
                              phoneNumberController.clear();
                              fullnameController.clear();
                              Navigator.pushReplacementNamed(
                                  context, testPage.screenRoute);
                            }
                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("${e.code.toUpperCase()}")));
                          }

                          print(emailController.text);
                          print(passwordController.text);
                        },
                        child: Text(
                          "Sign Up Now",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: <Widget>[
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        TextButton(
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, LoginPage.screenRoute);
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
