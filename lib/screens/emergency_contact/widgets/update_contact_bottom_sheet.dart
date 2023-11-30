import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hex_view/shared/widgets/custom_button.dart';

class UpdateContactDetailsBottomSheet extends StatefulWidget {
  final Function(
      {required String updatedContactNum,
      required String updatedContactName,
      required String initialContactName}) getUpdatedContactInfo;
  final String initalContactName;
  const UpdateContactDetailsBottomSheet(
      {super.key,
      required this.getUpdatedContactInfo,
      required this.initalContactName});

  @override
  State<UpdateContactDetailsBottomSheet> createState() =>
      _UpdateContactDetailsBottomSheetState();
}

class _UpdateContactDetailsBottomSheetState
    extends State<UpdateContactDetailsBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  String enteredNewContactNum = '';
  String enteredNewContactName = '';

  _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return null;
    }

    _formKey.currentState!.save();

    widget.getUpdatedContactInfo(
      updatedContactName: enteredNewContactName,
      updatedContactNum: enteredNewContactNum,
      initialContactName: widget.initalContactName,
    );

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
            height: MediaQuery.of(context).size.height * 0.6,
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
                      'Update Emergency Contact',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('New Contact Name'),
                        hintText: 'Enter new contact name',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid contact name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredNewContactName = value!;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('New Contact Number'),
                        hintText: 'Enter new contact number',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid contact number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredNewContactNum = value!;
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    CustomTextButton(
                      label: 'Update',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
