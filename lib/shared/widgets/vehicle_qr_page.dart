import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hex_view/shared/widgets/custom_button.dart';
import 'package:hex_view/shared/widgets/custom_snackbar.dart';
import 'package:hex_view/shared/widgets/info_card.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class VehicleQRScreen extends StatefulWidget {
  final String vehicleName, vehicleNum;
  const VehicleQRScreen(
      {super.key, required this.vehicleName, required this.vehicleNum});

  @override
  State<VehicleQRScreen> createState() => _VehicleQRScreenState();
}

class _VehicleQRScreenState extends State<VehicleQRScreen> {
  PermissionStatus _storagePermissonStatus = PermissionStatus.denied;
  final ScreenshotController _screenshotController = ScreenshotController();

  void requestStoragePermissions() async {
    await Permission.manageExternalStorage.request().then(
          (PermissionStatus status) => {
            setState(
              () {
                _storagePermissonStatus = status;
              },
            ),
          },
        );
  }

  void _shareQrCode() {
    requestStoragePermissions();
    if (_storagePermissonStatus.isGranted) {
      _screenshotController.capture().then((Uint8List? qrCodeImage) async {
        if (qrCodeImage != null) {
          final String captureTimestamp = DateTime.now().toString();
          await ImageGallerySaver.saveImage(
            Uint8List.fromList(qrCodeImage),
            quality: 100,
            name: captureTimestamp,
          );
          if (mounted) {
            CustomSnackBar.show(context, 'QR Code saved in your gallery!');
          }
        }
      });
    } else if (_storagePermissonStatus.isPermanentlyDenied) {
      if (mounted) {
        CustomSnackBar.show(
            context, 'Please grant storage permission to save QR codes');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          flex: 4,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Screenshot(
                controller: _screenshotController,
                child: QrImageView(
                  data:
                      'https://otp-auth-48162.web.app/${FirebaseAuth.instance.currentUser!.uid}/${widget.vehicleNum}',
                  version: QrVersions.auto,
                  size: 260.0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 20,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            width: double.maxFinite,
            child: Column(
              children: [
                InfoCard(
                  label: 'Vehicle number',
                  value: widget.vehicleNum,
                  backgroundColor: Colors.grey.shade100,
                ),
                const SizedBox(
                  height: 10,
                ),
                InfoCard(
                  label: 'Vehicle name',
                  value: widget.vehicleName,
                  backgroundColor: Colors.grey.shade100,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextButton(
                  label: 'Save to gallery',
                  onpressed: _shareQrCode,
                  outlined: false,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
