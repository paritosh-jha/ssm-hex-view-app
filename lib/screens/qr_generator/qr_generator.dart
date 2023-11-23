import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGeneratorScreen extends StatefulWidget {
  final String vehicleNumber;
  const QrGeneratorScreen({super.key, required this.vehicleNumber});

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImageView(
                data:
                    'https://otp-auth-48162.web.app/${FirebaseAuth.instance.currentUser!.uid}/${widget.vehicleNumber}',
                version: QrVersions.auto,
                size: 260.0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
