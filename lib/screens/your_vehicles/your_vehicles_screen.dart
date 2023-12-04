import 'package:flutter/material.dart';
import 'package:hex_view/firebase/user_methods.dart';
import 'package:hex_view/shared/widgets/add_vehicle_detail_bottom_sheet.dart';
import 'package:hex_view/screens/your_vehicles/widgets/vehicle_grid.dart';
import 'package:hex_view/shared/widgets/custom_button.dart';
import 'package:hex_view/shared/widgets/custom_loader.dart';
import 'package:hex_view/shared/widgets/custom_snackbar.dart';

class YourVehiclesScreen extends StatefulWidget {
  const YourVehiclesScreen({super.key});

  @override
  State<YourVehiclesScreen> createState() => _YourVehiclesScreenState();
}

class _YourVehiclesScreenState extends State<YourVehiclesScreen> {
  Map<String, String>? vehicles = {};
  bool areUserVehiclesAvailable = false;
  bool isBottomSheetOpen = false;

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
    //sort the vehicle map
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

  addVehicle({
    required String vehicleNickname,
    required String vehicleNum,
  }) async {
    if (vehicles!.containsKey(vehicleNickname)) {
      CustomSnackBar.show(context, "Vehicle with same name exists.");
      return;
    }
    if (vehicles!.containsValue(vehicleNum)) {
      CustomSnackBar.show(context, "Vehicle with same number exists.");
      return;
    }

    vehicles![vehicleNickname] = vehicleNum;

    //update the vehicle in firebase
    final res = await UserMethods().addUserVehicle(vehicles: vehicles);

    if (mounted && res == 'success') {
      CustomSnackBar.show(context, res);
      setState(() {
        fetchUserVehicles();
      });
    }
  }

  showAddVehicleBottomSheet(BuildContext context) {
    showBottomSheet(
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        isBottomSheetOpen = true;
        return AddVehicleDetailsBottomSheet(addVehicle: addVehicle);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Vehicles'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: !areUserVehiclesAvailable
              ? const CustomLoader()
              : Column(
                  children: [
                    Expanded(
                      child: VehicleGrid(
                        vehicles: vehicles!,
                      ),
                    ),
                    Builder(builder: (BuildContext context) {
                      return CustomTextButton(
                        label: "Add Vehicle",
                        onpressed: () {
                          showAddVehicleBottomSheet(context);
                        },
                        outlined: false,
                      );
                    })
                  ],
                ),
        ),
      ),
    );
  }
}
