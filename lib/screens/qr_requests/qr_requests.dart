import 'package:flutter/material.dart';
import 'package:hex_view/screens/qr_generator/qr_generator.dart';
import 'package:hex_view/screens/qr_requests/widgets/req_list.dart';

class QRRequestsScreen extends StatefulWidget {
  final String vehicleNickname;
  final String vehicleNumber;
  const QRRequestsScreen(
      {super.key, required this.vehicleNumber, required this.vehicleNickname});

  @override
  State<QRRequestsScreen> createState() => _QRRequestsScreenState();
}

class _QRRequestsScreenState extends State<QRRequestsScreen> {
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
                builder: (context) => QrGeneratorScreen(
                    vehicleNumber: widget.vehicleNumber,
                    vehicleNickname: widget.vehicleNumber),
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
}
