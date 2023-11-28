import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hex_view/firebase/auth_methods.dart';
import 'package:hex_view/model/user.dart' as model;
import 'package:hex_view/screens/emergency_contact/emergency_contact.dart';
import 'package:hex_view/screens/view_qr/view_qr.dart';

class AccountScreen extends StatefulWidget {
  final model.User userData;
  const AccountScreen({
    super.key,
    required this.userData,
  });

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  showLogOutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Please Confirm'),
        content: const Text('Do you wish to log out?'),
        actions: [
          TextButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                foregroundColor: MaterialStatePropertyAll(Colors.redAccent)),
            onPressed: () {
              AuthMethods().signOutUser();
              Navigator.of(context).pop();
            },
            child: const Text(
              'Yes',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                foregroundColor: MaterialStatePropertyAll(Colors.black87)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'No',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hello, ${widget.userData.name}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    child: Icon(
                      FluentIcons.person_20_filled,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const Divider(
                height: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: const Icon(Icons.emergency),
                title: const Text('Emergency Contact'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const EmergencyContactScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.qr_code_rounded),
                title: const Text('Your QRs'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewQRScreen(
                            userData: widget.userData,
                          )));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout_rounded),
                title: const Text('Sign Out'),
                onTap: () {
                  showLogOutDialog();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
