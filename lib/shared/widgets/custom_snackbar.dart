import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context, String res) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1500),
        closeIconColor: Colors.black87,
        showCloseIcon: true,
        backgroundColor: Colors.grey.shade200,
        elevation: 2,
        behavior: SnackBarBehavior.floating,
        content: Text(
          res,
          style: const TextStyle(color: Colors.black87, fontSize: 15),
        ),
      ),
    );
  }
}
