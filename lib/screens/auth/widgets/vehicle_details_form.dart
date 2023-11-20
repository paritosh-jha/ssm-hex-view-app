import 'package:flutter/material.dart';
import 'package:hex_view/shared/widgets/custom_button.dart';

class VehicleDetailsForm extends StatefulWidget {
  final Function({required List<String> vehicleNum}) getVehicleDetails;

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
  List<String> addedVehicles = [];

  _onSubmit() {
    widget.pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    widget.getVehicleDetails(vehicleNum: addedVehicles);
  }

  addVehicleNumber() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return null;
    }
    _formKey.currentState!.save();

    FocusScope.of(context).unfocus();

    addedVehicles.add(enteredVehicleNum);
    _formKey.currentState!.reset();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const Text(
                    'Added Vechicles',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 150,
                    child: addedVehicles.isEmpty
                        ? const Center(
                            child: Text('No vehicles added'),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Card(
                                  color: Colors.grey.shade200,
                                  child: ListTile(
                                    title: Text(addedVehicles[index]),
                                    trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          addedVehicles.removeAt(index);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: addedVehicles.length,
                          ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextFormField(
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
                      ),
                      Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            backgroundColor: Colors.black87,
                            child: IconButton(
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onPressed: addVehicleNumber,
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
              Column(
                children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
