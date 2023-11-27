import 'package:flutter/material.dart';
import 'package:hex_view/firebase/auth_methods.dart';
import 'package:hex_view/screens/auth/widgets/login_form.dart';
import 'package:hex_view/shared/widgets/custom_loader.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ignore: unused_field
  bool _loading = false;

  void _signInHandler(String email, String password) async {
    FocusScope.of(context).unfocus();
    setState(() {
      _loading = true;
    });

    String res = await AuthMethods().signInUser(
      email,
      password,
    );

    if (res == 'success') {
      await navigateToHomeScreen();
    }
    setState(() {
      _loading = false;
    });
    showSnackBar(res, context);
  }

  navigateToHomeScreen() {
    Navigator.of(context).pop();
  }

  showSnackBar(String res, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          res,
          style: const TextStyle(color: Colors.black87),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor:
            res == 'success' ? Colors.greenAccent : Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _loading
                ? const CustomLoader()
                : LoginForm(
                    signInHandler: _signInHandler,
                  ),
          ),
        ),
      ),
    );
  }
}
