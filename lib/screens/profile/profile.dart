import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hex_view/firebase/user_methods.dart';
import 'package:hex_view/model/user.dart' as model;
import 'package:hex_view/screens/profile/widgets%20/update_username_bottom_sheet.dart';
import 'package:hex_view/shared/widgets/custom_snackbar.dart';

class ProfileScreen extends StatefulWidget {
  final model.User? userData;
  final Function() onUpdate;
  const ProfileScreen(
      {super.key, required this.userData, required this.onUpdate});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "";
  String contact = "";
  showUpdateUserNameBottomSheet(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return UpdateUserNameBottomSheet(updateUserName: updateUserName);
      },
    );
  }

  updateUserName({required String username}) async {
    setState(() {
      userName = username;
    });
    final res = await UserMethods().updateUserName(username: username);

    if (mounted) CustomSnackBar.show(context, res);

    widget.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    userName = widget.userData!.name;
    contact = widget.userData!.phone;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Hero(
              tag: 'profile-picture',
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                child: Icon(
                  FluentIcons.person_20_filled,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              leading: const Icon(
                FluentIcons.person_20_filled,
                size: 30,
              ),
              title: const Text(
                "Name",
                style: TextStyle(fontSize: 14),
              ),
              subtitle: Text(
                userName,
                style: const TextStyle(fontSize: 16),
              ),
              trailing: Builder(builder: (context) {
                return IconButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.grey.shade100)),
                  onPressed: () {
                    showUpdateUserNameBottomSheet(context);
                  },
                  icon: const Icon(
                    FluentIcons.edit_16_filled,
                    size: 15,
                  ),
                );
              }),
            ),
            ListTile(
              leading: const Icon(
                FluentIcons.call_20_filled,
                size: 30,
              ),
              title: const Text(
                "Phone",
                style: TextStyle(fontSize: 14),
              ),
              subtitle: Text(
                "+91 $contact",
                style: const TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
