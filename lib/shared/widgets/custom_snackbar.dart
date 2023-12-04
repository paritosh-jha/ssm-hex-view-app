import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context, String res) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          res,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
