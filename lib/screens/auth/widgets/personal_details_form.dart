import 'package:flutter/material.dart';
import 'package:hex_view/shared/widgets/custom_button.dart';

class PersonalDetailsForm extends StatefulWidget {
  final Function({
    required String name,
    required String phone,
    required String emergencyContact1,
    required String emergencyContact2,
  }) getPersonalDetails;
  final PageController pageController;

  const PersonalDetailsForm(
      {super.key,
      required this.pageController,
      required this.getPersonalDetails});

  @override
  State<PersonalDetailsForm> createState() => _PersonalDetailsFormState();
}

class _PersonalDetailsFormState extends State<PersonalDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  String enteredName = '';
  String enteredPhone = '';
  String enteredEmergencyContact1 = '';
  String enteredEmergencyContact2 = '';

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

    widget.getPersonalDetails(
      name: enteredName,
      phone: enteredPhone,
      emergencyContact1: enteredEmergencyContact1,
      emergencyContact2: enteredEmergencyContact1,
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
                  "Personal Details",
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
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
                initialValue: enteredName,
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
                initialValue: enteredPhone,
                onSaved: (value) {
                  enteredPhone = value!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Emergency Contact 1',
                ),
                autocorrect: false,
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
                  enteredEmergencyContact1 = value!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Emergency Contact 2',
                ),
                autocorrect: false,
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
                  enteredEmergencyContact2 = value!;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              CustomTextIconButton(
                label: 'Next',
                icon: const Icon(Icons.arrow_forward_outlined),
                onpressed: _onSubmit,
                outlined: false,
                iconColor: Colors.white,
              ),
              const SizedBox(
                height: 15,
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
      ),
    );
  }
}
