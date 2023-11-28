import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hex_view/model/user.dart' as model;
import 'package:hex_view/shared/widgets/custom_button.dart';
import 'package:hex_view/shared/widgets/info_card.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ViewQRScreen extends StatefulWidget {
  final model.User userData;
  const ViewQRScreen({super.key, required this.userData});

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
          itemBuilder: (context, index) {
            final entry = widget.userData.vehicles.entries.elementAt(index);
            final vehicleName = entry.key;
            final vehicleNum = entry.value;
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
                      child: QrImageView(
                        data:
                            'https://otp-auth-48162.web.app/${FirebaseAuth.instance.currentUser!.uid}',
                        version: QrVersions.auto,
                        size: 260.0,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
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
                            topRight: Radius.circular(30))),
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        InfoCard(
                          label: 'Vehicle number',
                          value: vehicleNum,
                          backgroundColor: Colors.grey.shade100,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InfoCard(
                          label: 'Vehicle name',
                          value: vehicleName,
                          backgroundColor: Colors.grey.shade100,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextButton(
                          label: 'Save to gallery',
                          onpressed: () {},
                          outlined: false,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          itemCount: widget.userData.vehicles.length,
        ),
      ),
    );
  }
}
