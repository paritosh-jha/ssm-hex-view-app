import 'package:flutter/material.dart';
import 'package:hex_view/screens/your_vehicles/widgets/vehicle_item_detail_modal.dart';
import 'package:hex_view/screens/your_vehicles/widgets/vehicle_grid_tile.dart';

class VehicleGrid extends StatefulWidget {
  final Function({required String vehicleName, required String vehicleNum})
      onEditVehcileName, onRemoveVehicle;
  final Map<String, String> vehicles;
  const VehicleGrid({
    super.key,
    required this.vehicles,
    required this.onEditVehcileName,
    required this.onRemoveVehicle,
  });

  @override
  State<VehicleGrid> createState() => _VehicleGridState();
}

class _VehicleGridState extends State<VehicleGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.vehicles.length, //3 => 0,1,2
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final vehicle = widget.vehicles.entries.elementAt(index);
        final vehicleName = vehicle.key;
        final vehicleNum = vehicle.value;
        return VehicleGridTile(
          vehicleName: vehicleName,
          vehicleNum: vehicleNum,
          onPressed: () {
            showModalBottomSheet(
              showDragHandle: true,
              backgroundColor: Colors.white,
              context: context,
              builder: (BuildContext context) {
                return VehicleItemDetailModal(
                  vehicleName: vehicleName,
                  vehicleNum: vehicleNum,
                  onEditVehicleName: () {
                    widget.onEditVehcileName(
                        vehicleName: vehicleName, vehicleNum: vehicleNum);
                  },
                  onRemoveVehicle: () {
                    widget.onRemoveVehicle(
                        vehicleName: vehicleName, vehicleNum: vehicleNum);
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
