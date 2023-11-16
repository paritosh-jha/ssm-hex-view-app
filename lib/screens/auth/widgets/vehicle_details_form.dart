import 'package:flutter/material.dart';
import 'package:hex_view/shared/widgets/custom_button.dart';

class VehicleDetailsForm extends StatefulWidget {
  final Function({required String vehicleNum}) getVehicleDetails;

  final PageController pageController;
  const VehicleDetailsForm(
      {super.key,
      required this.pageController,
      required this.getVehicleDetails});

  @override
  State<VehicleDetailsForm> createState() => _VehicleDetailsFormState();
}

class _VehicleDetailsFormState extends State<VehicleDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  String enteredVehicleNum = '';

  _onSubmit() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return null;
    }
    _formKey.currentState!.save();

    widget.pageController.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );

    widget.getVehicleDetails(vehicleNum: enteredVehicleNum);
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
                  "Vehicle Details",
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 25,
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
              const SizedBox(
                height: 15,
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
