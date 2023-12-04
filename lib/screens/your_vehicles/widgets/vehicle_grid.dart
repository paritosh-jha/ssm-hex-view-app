import 'package:flutter/material.dart';
import 'package:hex_view/screens/your_vehicles/widgets/vehicle_tile.dart';

class VehicleGrid extends StatelessWidget {
  final Map<String, String> vehicles;
  const VehicleGrid({super.key, required this.vehicles});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: vehicles.length, //3 => 0,1,2
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final vehicle = vehicles.entries.elementAt(index);
        final vehicleName = vehicle.key;
        final vehicleNum = vehicle.value;

        return VehicleTile(
          vehicleName: vehicleName,
          vehicleNum: vehicleNum,
        );
      },
    );
  }
}
