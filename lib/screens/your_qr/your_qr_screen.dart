import 'package:flutter/material.dart';
import 'package:hex_view/model/user.dart' as model;
import 'package:hex_view/shared/widgets/vehicle_qr_page.dart';

class YourQRScreen extends StatefulWidget {
  final model.User userData;
  const YourQRScreen({
    super.key,
    required this.userData,
  });

  @override
  State<YourQRScreen> createState() => _YourQRScreenState();
}

class _YourQRScreenState extends State<YourQRScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your QRs'),
        ),
        body: PageView.builder(
          key: const PageStorageKey<String>('pageViewKey'),
          itemBuilder: (context, index) {
            final entry = widget.userData.vehicles.entries.elementAt(index);
            final vehicleName = entry.key;
            final vehicleNum = entry.value;
            return VehicleQRScreen(
              vehicleName: vehicleName,
              vehicleNum: vehicleNum,
            );
          },
          itemCount: widget.userData.vehicles.length,
        ),
      ),
    );
  }
}
