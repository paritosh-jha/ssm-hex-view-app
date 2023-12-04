import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hex_view/shared/widgets/custom_button.dart';

class VehicleItemDetailModal extends StatelessWidget {
  final Function() onEditVehicleName, onRemoveVehicle;
  final String vehicleName, vehicleNum;
  const VehicleItemDetailModal(
      {super.key,
      required this.vehicleName,
      required this.vehicleNum,
      required this.onEditVehicleName,
      required this.onRemoveVehicle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                child: Icon(FluentIcons.vehicle_car_20_filled),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    vehicleName,
                    style: const TextStyle(fontSize: 26),
                  ),
                  Text(
                    vehicleNum,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextButton(
                label: 'Edit Vehicle Name',
                onpressed: onEditVehicleName,
                outlined: false,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextButton(
                label: 'Remove vehicle',
                onpressed: onRemoveVehicle,
                outlined: false,
                color: Colors.red,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextButton(
                label: 'Cancel',
                onpressed: () {
                  Navigator.of(context).pop();
                },
                outlined: true,
              )
            ],
          ),
        ],
      ),
    );
  }
}
