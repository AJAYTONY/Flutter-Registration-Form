import 'package:flutter/material.dart';

class Utility {
  static showSnackBar(BuildContext context,
      {required String message, Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: color,
    ));
  }

  static showErrorSnackBar(BuildContext context, {required String message}) {
    showSnackBar(context, message: message, color: Colors.red[400]);
  }

  static showSuccessSnackBar(BuildContext context, {required String message}) {
    showSnackBar(context, message: message, color: Colors.green[400]);
  }
}
