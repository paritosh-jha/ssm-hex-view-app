import 'package:flutter/material.dart';
import 'package:hex_view/firebase/auth_methods.dart';

import 'package:hex_view/screens/auth/widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ignore: unused_field
  bool _loading = false;

  void _signInHandler(
    String email,
    String password,
  ) async {
    setState(() {
      _loading = true;
    });

    String res = await AuthMethods().signInUser(
      email,
      password,
    );

    setState(() {
      _loading = false;
    });
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LoginForm(
              signInHandler: _signInHandler,
            ),
          ),
        ),
      ),
    );
  }
}
