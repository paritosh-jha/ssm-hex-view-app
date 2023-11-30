import 'package:flutter/material.dart';
import 'package:hex_view/shared/widgets/vehicle_qr_page.dart';


class QrGeneratorScreen extends StatefulWidget {
  final String vehicleNumber, vehicleNickname;
  const QrGeneratorScreen({super.key, required this.vehicleNumber, required this.vehicleNickname});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your QR Code',
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: VehicleQRScreen(vehicleName: widget.vehicleNickname, vehicleNum: widget.vehicleNumber)
      ),
    );
  }
}
