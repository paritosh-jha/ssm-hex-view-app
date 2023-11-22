import 'package:flutter/material.dart';
import 'package:hex_view/firebase/user_methods.dart';
import 'package:hex_view/model/user.dart' as model;
import 'package:hex_view/screens/qr_connect/widgets/vehicle_list.dart';
import 'package:hex_view/shared/widgets/custom_loader.dart';

class QrConnectVehicleList extends StatefulWidget {
  const QrConnectVehicleList({super.key});

  @override
  State<QrConnectVehicleList> createState() => _QrConnectVehicleListState();
}

class _QrConnectVehicleListState extends State<QrConnectVehicleList> {
  bool userDataReady = false;
  late model.User? userData;

  void fetchUserData() async {
    userData = await UserMethods().getUserDetails();
    if (userData == null) {
      //handle null case
      // print('Curr User Obj is NULL');
      return;
    }
    setState(() {
      userDataReady = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !userDataReady
          ? const CustomLoader()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your vehicles',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: VehicleList(
                    vehicles: userData!.vehicles,
                  ),
                ),
              ],
            ),
    );
  }
}
