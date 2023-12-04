import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hex_view/shared/widgets/custom_button.dart';

class VehicleItemDetailModal extends StatelessWidget {
  final String vehicleName, vehicleNum;
  const VehicleItemDetailModal(
      {super.key, required this.vehicleName, required this.vehicleNum});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                height: 25,
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
                onpressed: () {},
                outlined: false,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextButton(
                label: 'Remove vehicle',
                onpressed: () {},
                outlined: false,
                color: Colors.red,
              )
            ],
          ),
        ],
      ),
    );
  }
}
