import 'package:flutter/material.dart';
import 'package:hex_view/shared/widgets/custom_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginState();
}

class _LoginState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          child: Column(
            children: [
              const Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const TextField(
                decoration: InputDecoration(
                    label: Text('Email'), hintText: 'Enter your email'),
              ),
              const SizedBox(
                height: 15,
              ),
              const TextField(
                decoration: InputDecoration(
                    label: Text('Password'), hintText: 'Enter your password'),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextIconButton(
                label: 'Sign in',
                icon: const Icon(Icons.arrow_forward_rounded),
                iconColor: Colors.white,
                outlined: false,
                onpressed: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              CustomOutlinedTextButton(
                label: 'Cancel',
                onpressed: () {
                  Navigator.pop(context);
                },
                outlined: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
