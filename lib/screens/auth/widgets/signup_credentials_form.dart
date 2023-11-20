import 'package:flutter/material.dart';
import 'package:hex_view/shared/widgets/custom_button.dart';

class SignUpCredentialsForm extends StatefulWidget {
  final Function({required String email, required String password})
      getSignUpCredentials;
  final PageController pageController;
  const SignUpCredentialsForm(
      {super.key,
      required this.pageController,
      required this.getSignUpCredentials});

  @override
  State<SignUpCredentialsForm> createState() => _SignUpCredentialsFormState();
}

class _SignUpCredentialsFormState extends State<SignUpCredentialsForm> {
  final _formKey = GlobalKey<FormState>();
  String enteredEmail = '';
  String enteredPassword = '';

  _onSubmit() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return null;
    }
    _formKey.currentState!.save();

    FocusScope.of(context).unfocus();

    widget.pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    widget.getSignUpCredentials(
      email: enteredEmail,
      password: enteredPassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Sign Up Credentials",
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Email'),
                  hintText: 'Enter your email',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a valid email';
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
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.length < 6) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                onSaved: (value) {
                  enteredPassword = value!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextIconButton(
                label: 'Sign up',
                icon: const Icon(Icons.arrow_forward_outlined),
                onpressed: _onSubmit,
                outlined: false,
                iconColor: Colors.white,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomOutlinedTextButton(
                label: 'Back',
                onpressed: () {
                  widget.pageController.previousPage(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                  );
                },
                outlined: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
