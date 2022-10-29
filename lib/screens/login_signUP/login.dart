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
GlobalKey<FormState> myFormKey = GlobalKey();
bool scureText = true;

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> myFormKey = GlobalKey();
  bool scureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 10,
            title: Row(
              children: [
                FaIcon(
                  size: constraints.maxHeight * 0.035,
                  FontAwesomeIcons.accusoft,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Stack",
                  style: Theme.of(context).textTheme.bodyText1,
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
                      Text("Welcome Back!",
                          style:
                              TextStyle(fontSize: constraints.maxHeight * .045),
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
                          textInputAction: TextInputAction.done,
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            } else {
                              return null;
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
                      SizedBox(
                        height: 50,
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
                                var auth = await FirebaseAuth.instance;

                                UserCredential myUser =
                                    await auth.signInWithEmailAndPassword(
                                        email: emailController!.text.trim(),
                                        password:
                                            passwordController!.text.trim());
                                emailController!.clear();
                                passwordController!.clear();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("login successfully")));

                                if (myUser != null) {
                                  Navigator.of(context).pop();
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "No user found for that email.")));
                                } else if (e.code == 'wrong-password') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Wrong password provided for that user.")));
                                }
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
                        onPressed: () {
                          Navigator.pushNamed(context, "forgotPassword");
                        },
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
                              try {
                                await signInWithGoogle();
                                Navigator.of(context).pop();
                              } catch (err) {}
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
                              Navigator.pushNamed(context, "/sign_up");
                            },
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      )
                    ]),
              ),
            ),
          ),
        );
      }),
    );
  }
}
