import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hex_view/firebase/auth_methods.dart';
import 'package:hex_view/screens/auth/widgets/signup_form.dart';

final _firebase = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // ignore: unused_field
  bool _loading = false;
  late UserCredential userCredentials;

  void _signUpHandler(
    String name,
    String phone,
    String email,
    String password,
    String vehicleNum,
    String vehicleRegNum,
    String emergencyContact1,
    String emergencyContact2,
  ) async {
    setState(() {
      _loading = true;
    });

    // String res = await AuthMethods().signUpUser(
    //   name,
    //   email,
    //   password,
    //   phone,
    //   vehicleNum,
    //   vehicleRegNum,
    //   emergencyContact1,
    //   emergencyContact2,
    // );
    try {
      userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: email, password: password);
      print('success');
    } catch (e) {
      print(e);
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SignUpForm(
              signUpHandler: _signUpHandler,
            ),
          ),
        ),
      ),
    );
  }
}
