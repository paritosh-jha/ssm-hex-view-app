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
  String enteredEmergencyContactName1 = '';
  String enteredEmergencyContactName2 = '';

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
              Container(
                padding: const EdgeInsets.only(left: 5),
                width: double.infinity,
                child: const Text(
                  'Name',
                  textAlign: TextAlign.start,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
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
              Container(
                padding: const EdgeInsets.only(left: 5),
                width: double.infinity,
                child: const Text(
                  'Phone',
                  textAlign: TextAlign.start,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
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
              Container(
                padding: const EdgeInsets.only(left: 5),
                width: double.infinity,
                child: const Text(
                  'Emergency Info - 1',
                  textAlign: TextAlign.start,
                ),
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: 'Enter name'),
                      autocorrect: false,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredEmergencyContactName1 = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Enter Contact'),
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
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.only(left: 5),
                width: double.infinity,
                child: const Text(
                  'Emergency Info - 2',
                  textAlign: TextAlign.start,
                ),
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: 'Enter name'),
                      autocorrect: false,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredEmergencyContactName2 = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Enter Contact'),
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
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              CustomTextIconButton(
                label: 'Next',
                icon: Icons.arrow_forward_outlined,
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
