import 'package:flutter/material.dart';
import 'package:hex_view/model/user.dart' as model;
import 'package:hex_view/screens/view_qr/widgets/vehicle_qr_page.dart';

class ViewQRScreen extends StatefulWidget {
  final model.User userData;
  const ViewQRScreen({
    super.key,
    required this.userData,
  });

  @override
  State<ViewQRScreen> createState() => _ViewQRScreenState();
}

class _ViewQRScreenState extends State<ViewQRScreen> {
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
