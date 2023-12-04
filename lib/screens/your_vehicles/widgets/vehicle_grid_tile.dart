import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class VehicleGridTile extends StatefulWidget {
  final Function() onPressed;
  final String vehicleName, vehicleNum;
  const VehicleGridTile(
      {super.key,
      required this.vehicleName,
      required this.vehicleNum,
      required this.onPressed});

  @override
  State<VehicleGridTile> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<VehicleGridTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
      onTap: widget.onPressed,
        child: GridTile(
          child: Column(
            children: [
              const Expanded(
                flex: 2,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  child: Icon(FluentIcons.vehicle_car_20_filled),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      widget.vehicleName,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      widget.vehicleNum,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
