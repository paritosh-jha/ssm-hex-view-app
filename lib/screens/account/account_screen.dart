import 'package:flutter/material.dart';
import 'package:hex_view/firebase/auth_methods.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Paritosh Jha',
                  style: TextStyle(fontSize: 24),
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
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
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign Out'),
              onTap: () {
                AuthMethods().signOutUser();
              },
            ),
          ],
        ),
      ),
    );
  }
}
