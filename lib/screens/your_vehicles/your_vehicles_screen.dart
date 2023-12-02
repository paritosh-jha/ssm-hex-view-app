import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hex_view/firebase/user_methods.dart';
import 'package:hex_view/screens/your_vehicles/widgets/vehicle_tile.dart';
import 'package:hex_view/shared/widgets/custom_loader.dart';

class YourVehiclesScreen extends StatefulWidget {
  const YourVehiclesScreen({super.key});

  @override
  State<YourVehiclesScreen> createState() => _YourVehiclesScreenState();
}

class _YourVehiclesScreenState extends State<YourVehiclesScreen> {
  Map<String, String>? vehicles = {};
  bool areUserVehiclesAvailable = false;

  @override
  void initState() {
    super.initState();
    fetchUserVehicles();
  }

  fetchUserVehicles() async {
    setState(() {
      areUserVehiclesAvailable = false;
    });
    vehicles = await UserMethods().getUserVehicles();
    if (vehicles == null) {
      // print('vehicles is NULL');
      return;
    }
    //sort the emergency contacts
    var sortedKeys = vehicles!.keys.toList()..sort();
    Map.fromEntries(
      sortedKeys.map(
        (key) => MapEntry(
          key,
          vehicles![key],
        ),
      ),
    );

    setState(() {
      // print(vehicles);
      areUserVehiclesAvailable = true;
    });
  }

  addVehicle({required String vehicleName, required String vehicleNum}) {
    vehicles![vehicleName] = vehicleNum;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Vehicles'),
        ),
        body: !areUserVehiclesAvailable
            ? const CustomLoader()
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: vehicles!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final vehicle = vehicles!.entries.elementAt(index);
                    final vehicleName = vehicle.key;
                    final vehicleNum = vehicle.value;
                    return VehicleTile(
                      vehicleName: vehicleName,
                      vehicleNum: vehicleNum,
                    );
                  },
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                FluentIcons.add_20_filled,
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}
