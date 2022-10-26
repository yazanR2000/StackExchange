import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  static const String screenRoute = "SignUp";
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
