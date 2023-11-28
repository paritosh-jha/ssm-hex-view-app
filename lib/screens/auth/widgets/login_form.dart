import 'package:flutter/material.dart';
import 'package:hex_view/shared/widgets/custom_button.dart';

class LoginForm extends StatefulWidget {
  final Function(String, String) signInHandler;
  const LoginForm({super.key, required this.signInHandler});

  @override
  State<LoginForm> createState() => _LoginState();
}

class _LoginState extends State<LoginForm> {
  String enteredEmail = '';
  String enteredPassword = '';

  final _formKey = GlobalKey<FormState>();

  _onSubmit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return null;
    }
    _formKey.currentState!.save();

    widget.signInHandler(
      enteredEmail,
      enteredPassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
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
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Email'),
                  hintText: 'Enter your email',
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                  enteredEmail = value!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Password'),
                  hintText: 'Enter your password',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                onSaved: (value) {
                  enteredPassword = value!;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextIconButton(
                label: 'Sign in',
                icon: Icons.arrow_forward_rounded,
                iconColor: Colors.white,
                outlined: false,
                onpressed: _onSubmit,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextButton(
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
