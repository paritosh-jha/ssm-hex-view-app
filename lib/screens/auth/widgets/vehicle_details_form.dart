import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hex_view/shared/widgets/add_vehicle_detail_bottom_sheet.dart';
import 'package:hex_view/shared/widgets/custom_button.dart';

class VehicleDetailsForm extends StatefulWidget {
  final Function({required Map<String, String> vehicleNum}) getVehicleDetails;

  final PageController pageController;
  const VehicleDetailsForm(
      {super.key,
      required this.pageController,
      required this.getVehicleDetails});

  @override
  State<VehicleDetailsForm> createState() => _VehicleDetailsFormState();
}

class _VehicleDetailsFormState extends State<VehicleDetailsForm> {
  Map<String, String> addedVehicles = {};

  _onSubmit() {
    if (addedVehicles.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Alert'),
            content: const Text('Please add atleast one vehicle'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              )
            ],
          );
        },
      );
    } else {
      widget.pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      widget.getVehicleDetails(vehicleNum: addedVehicles);
    }
  }

  showAddVehicleBottomModal() {
    showBottomSheet(
      elevation: 1,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return AddVehicleDetailsBottomSheet(
          addVehicle: addVehicle,
        );
      },
    );
  }

  addVehicle({required String vehicleNum, required String vehicleNickname}) {
    // print(vehicleNickname);
    addedVehicles[vehicleNickname] = vehicleNum;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
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
                    height: 200,
                    child: addedVehicles.isEmpty
                        ? const Center(
                            child: Text('No vehicles added'),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final entry =
                                  addedVehicles.entries.elementAt(index);
                              final vehicleNickname = entry.key;
                              final vehicleNumber = entry.value;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Card(
                                  color: Colors.grey.shade200,
                                  child: ListTile(
                                    title: Text(vehicleNickname),
                                    subtitle: Text(vehicleNumber),
                                    trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          addedVehicles.remove(vehicleNickname);
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
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
              Column(
                children: [
                  CustomTextButton(
                    label: 'Add Vehicle',
                    onpressed: () {
                      showAddVehicleBottomModal();
                    },
                    outlined: true,
                  ),
                  const SizedBox(
                    height: 15,
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
