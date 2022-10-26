import 'package:flutter/material.dart';

class Error {
  static void snackBarError(String error, BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(error),
      ),
    );
  }
}
