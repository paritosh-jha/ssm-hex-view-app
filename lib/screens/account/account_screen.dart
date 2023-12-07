import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hex_view/firebase/auth_methods.dart';
import 'package:hex_view/firebase/user_methods.dart';
import 'package:hex_view/model/user.dart' as model;
import 'package:hex_view/screens/emergency_contact/emergency_contact.dart';
import 'package:hex_view/screens/profile/profile.dart';
import 'package:hex_view/screens/your_qr/your_qr_screen.dart';
import 'package:hex_view/screens/your_vehicles/your_vehicles_screen.dart';
import 'package:hex_view/shared/widgets/custom_loader.dart';

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
  bool isUserDataAvailible = false;
  late model.User? userData;

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

  void fetchUserData() async {
    userData = await UserMethods().getUserDetails();
    if (userData == null) {
      //handle null case
      // print('Curr User Obj is NULL');
      return;
    }
    setState(() {
      isUserDataAvailible = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: !isUserDataAvailible
            ? const CustomLoader()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                                  userData: userData,
                                  onUpdate : (){
                                    fetchUserData();
                                  }
                                )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Hero(
                                  tag: 'profile-picture',
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey,
                                    foregroundColor: Colors.white,
                                    child: Icon(
                                      FluentIcons.person_20_filled,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Hello, ',
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 22),
                                    children: [
                                      TextSpan(
                                        text: userData!.name,
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 22),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Divider(
                      height: 2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      style: ListTileStyle.drawer,
                      leading: const Icon(FluentIcons.vehicle_car_20_regular),
                      title: const Text('Your Vehicles'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const YourVehiclesScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      style: ListTileStyle.drawer,
                      leading: const Icon(Icons.qr_code_rounded),
                      title: const Text('Your QRs'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => YourQRScreen(
                                  userData: widget.userData,
                                )));
                      },
                    ),
                    ListTile(
                      style: ListTileStyle.drawer,
                      leading: const Icon(Icons.emergency),
                      title: const Text('Emergency Contact'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const EmergencyContactScreen()));
                      },
                    ),
                    ListTile(
                      style: ListTileStyle.drawer,
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
