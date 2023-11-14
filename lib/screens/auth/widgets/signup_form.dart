import 'package:flutter/material.dart';
import 'package:hex_view/shared/widgets/custom_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.signUpHandler,
  });
  final Function(String, String, String, String, String, String, String, String)
      signUpHandler;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String enteredName = '';
  String enteredPhone = '';
  String enteredVehicleNum = '';
  String enteredVehicleRegNum = '';
  String enteredEmergencyContact1 = '';
  String enteredEmergencyContact2 = '';
  String enteredEmail = '';
  String enteredPassword = '';

  final _formKey = GlobalKey<FormState>();

  _onSubmit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return null;
    }
    _formKey.currentState!.save();

    widget.signUpHandler(
      enteredName,
      enteredPhone,
      enteredEmail,
      enteredPassword,
      enteredVehicleNum,
      enteredVehicleRegNum,
      enteredEmergencyContact1,
      enteredEmergencyContact2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Become a member!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Name'),
                  hintText: 'Enter your name',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a valid name';
                  }
                  return null;
                },
                onSaved: (value) {
                  enteredName = value!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Phone'),
                  hintText: 'Enter your phone number',
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.length < 10 ||
                      value.length > 10) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  enteredPhone = value!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Vehicle Number'),
                  hintText: 'Enter your vechicle num',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a valid vehicle number';
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
                  label: Text('Vehicle Reg. Number'),
                  hintText: 'Enter your vehicle\'s registration number',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a valid reg. number';
                  }
                  return null;
                },
                onSaved: (value) {
                  enteredVehicleRegNum = value!;
                },
              ),
              const SizedBox(
                height: 15,
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
                label: 'Create an account',
                icon: const Icon(Icons.arrow_forward_outlined),
                onpressed: _onSubmit,
                outlined: false,
                iconColor: Colors.white,
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
