import 'package:flutter/material.dart';
import 'package:hex_view/shared/screens/requests_screen/widgets/req_list.dart';
import 'package:hex_view/shared/widgets/vehicle_qr_page.dart';

class RequestsScreen extends StatefulWidget {
  final String vehicleNickname;
  final String vehicleNumber;
  const RequestsScreen(
      {super.key, required this.vehicleNumber, required this.vehicleNickname});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.vehicleNickname),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: RequestList(
                  vehicleNumber: widget.vehicleNumber,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => qrGenerator(
                    vehicleNumber: widget.vehicleNumber,
                    vehicleNickname: widget.vehicleNickname),
              ),
            );
          },
          child: const Icon(
            Icons.qr_code,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget qrGenerator(
      {required String vehicleNumber, required String vehicleNickname}) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your QR Code',
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: VehicleQRScreen(
          vehicleName: vehicleNickname,
          vehicleNum: vehicleNumber,
        ),
      ),
    );
  }
}
