import 'package:flutter/material.dart';

class VehicleInfo extends StatelessWidget {
  final String vehicle;
  const VehicleInfo({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Center(
        child: Text(vehicle),
      ),
    );
  }
}
