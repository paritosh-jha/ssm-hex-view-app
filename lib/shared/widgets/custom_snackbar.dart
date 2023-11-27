import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String res;
  const CustomSnackBar({super.key, required this.res});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(res),
      behavior: SnackBarBehavior.floating,
      backgroundColor: res == 'success' ? Colors.greenAccent : Colors.red,
    );
  }
}
