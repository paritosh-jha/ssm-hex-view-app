import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hex_view/shared/widgets/custom_button.dart';

class UpdateUserNameBottomSheet extends StatefulWidget {
  final Function({required String username}) updateUserName;
  const UpdateUserNameBottomSheet({super.key, required this.updateUserName});

  @override
  State<UpdateUserNameBottomSheet> createState() =>
      _UpdateUserNameBottomSheetState();
}

class _UpdateUserNameBottomSheetState extends State<UpdateUserNameBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  String enteredNewUserName = '';
  _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return null;
    }

    _formKey.currentState!.save();

    widget.updateUserName(username: enteredNewUserName);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
            Colors.grey.withOpacity(0.3), BlendMode.saturation),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 6.0,
            sigmaY: 6.0,
          ),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Update username',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('New username'),
                        hintText: 'Enter your new username',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredNewUserName = value!;
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextButton(
                      label: 'Save',
                      onpressed: _submit,
                      outlined: false,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
