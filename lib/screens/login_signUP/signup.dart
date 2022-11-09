import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../../models/user.dart' as u;

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
  String phonenumber = "07xxxxxx";
  TextEditingController fullnameController = TextEditingController();
  GlobalKey<FormState> myFormKey = GlobalKey();
  bool scureText = true;
  File? _image;
  Future getImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this._image = imageTemporary;
    });
  }

  Future _getUserData() async {
    final u.User _user = u.User.getInstance();
    await _user.addUserInfo();
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("Users").doc(userId).get();
    _user.userData = doc;
  }

  @override
  Widget build(BuildContext context) {
    final Function reload =
        ModalRoute.of(context)!.settings.arguments as Function;
    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 10,
              title: Row(
                children: [
                  Image.asset(
                    "images/smallLogo.png",
                    height: constraints.maxHeight * 0.06,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "QCODE",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            body: Form(
              key: myFormKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Welcome !",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: constraints.maxHeight * .045),
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
                        ListTile(
                          title: Text(
                            "Upload your Photo",
                            style: TextStyle(color: Colors.grey),
                          ),
                          onTap: () async {
                            await getImage();
                          },
                          // dense: true,
                          trailing: _image != null
                              ? Image.file(
                                  _image!,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons.person_outline_rounded,
                                  size: 60,
                                ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: ((value) {
                              // Check if this field is empty
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            }),
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
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: ((value) {
                              // Check if this field is empty
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }

                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return "Please enter a valid email address";
                              }

                              // the email is valid
                              return null;
                            }),
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
                            obscureText: scureText,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              } else {
                                if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$')
                                    .hasMatch(value)) {
                                  return 'Password must contain at least one \n"upper case, lower case and 8 characters in length"';
                                } else {
                                  return null;
                                }
                              }
                            }),
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  scureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: scureText ? Colors.grey : Colors.blue,
                                ),
                                onPressed: () {
                                  setState(() {
                                    scureText = !scureText;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: ((value) {
                              // Check if this field is empty
                            }),
                            onChanged: (value) {
                              phonenumber = phoneNumberController.text;
                            },
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
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 45, left: 45),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(constraints.maxHeight * 0.2,
                                  constraints.maxHeight * .06),
                              maximumSize: Size(constraints.maxHeight * 0.25,
                                  constraints.maxHeight * .07),
                            ),
                            onPressed: () async {
                              if (myFormKey.currentState!.validate()) {
                                try {
                                  var auth = FirebaseAuth.instance;
                                  final u.User _user = u.User.getInstance();
                                  UserCredential myUser =
                                      await auth.createUserWithEmailAndPassword(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                  _user.UserInfo = {
                                    'User Email': emailController.text,
                                    "image": _image == null ? "" : _image!.path,
                                    "Full name": fullnameController.text,
                                    "Phone number": phonenumber,
                                  };
                                  await _user.addUserInfo();

                                  User? verifyUser =
                                      FirebaseAuth.instance.currentUser;
                                  if (myUser.user!.emailVerified == false) {
                                    await verifyUser!.sendEmailVerification();
                                  }

                                  if (verifyUser!.emailVerified) {
                                    await _getUserData();
                                    emailController.clear();
                                    passwordController.clear();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("added successfully"),
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                    reload();
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Verification email has been sent",
                                        ),
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  }

                                  if (myUser != null) {
                                    phoneNumberController.clear();
                                    fullnameController.clear();
                                  }
                                } on FirebaseAuthException catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("${e.code.toUpperCase()}")));
                                }
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
                      ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
