import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hex_view/shared/widgets/custom_button.dart';

class VehicleDeatilsBottomSheet extends StatefulWidget {
  final Function({required String vehicleNum, required String vehicleNickname})
      addVehicle;
  const VehicleDeatilsBottomSheet({super.key, required this.addVehicle});

  @override
  State<VehicleDeatilsBottomSheet> createState() =>
      _VehicleDeatilsBottomSheetState();
}

class _VehicleDeatilsBottomSheetState extends State<VehicleDeatilsBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  String enteredVehicleNum = '';
  String enteredVehicleNickName = '';

  _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return null;
    }

    _formKey.currentState!.save();

    widget.addVehicle(
      vehicleNickname: enteredVehicleNickName,
      vehicleNum: enteredVehicleNum,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add vechicle details',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Vehicle Number'),
                        hintText: 'Enter your vehicle number',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid vehicle number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredVehicleNum = value!;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Vehicle Name'),
                        hintText: 'Enter a nickname for the vehicle',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid vehicle name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredVehicleNickName = value!;
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    CustomTextIconButton(
                      label: 'Add',
                      icon: Icons.arrow_forward_outlined,
                      onpressed: _submit,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
