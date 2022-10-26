import 'package:flutter/material.dart';

class Successfull {
  static void snackBarError(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(msg),
      ),
    );
  }
}
