import 'package:flutter/material.dart';
import 'package:hex_view/firebase/user_methods.dart';
import 'package:hex_view/screens/qr_connect/widgets/req_list.dart';

class QRConnectScreen extends StatefulWidget {
  const QRConnectScreen({super.key});

  @override
  State<QRConnectScreen> createState() => _QRConnectScreenState();
}

class _QRConnectScreenState extends State<QRConnectScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: const Text(
              "Requests",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Expanded(
            child: RequestList(),
          ),
        ],
      ),
    );
  }
}
