import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hex_view/firebase/user_methods.dart';
import 'package:hex_view/screens/emergency_contact/widgets/contact_card.dart';
import 'package:hex_view/screens/emergency_contact/widgets/update_contact_bottom_sheet.dart';
import 'package:hex_view/shared/widgets/custom_loader.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

class EmergencyContactScreen extends StatefulWidget {
  const EmergencyContactScreen({super.key});

  @override
  State<EmergencyContactScreen> createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  Map<String, String>? emergencyContacts = {};
  bool isUserEmailAvailable = false;

  @override
  void initState() {
    super.initState();
    fetchEmergencyContacts();
  }

  fetchEmergencyContacts() async {
    setState(() {
      isUserEmailAvailable = false;
    });
    emergencyContacts = await UserMethods().getEmergencyContacts();
    if (emergencyContacts == null) {
      print('EmergencyContacts is NULL');
      return;
    }
    //sort the emergency contacts
    var sortedKeys = emergencyContacts!.keys.toList()..sort();
    Map.fromEntries(
      sortedKeys.map(
        (key) => MapEntry(
          key,
          emergencyContacts![key],
        ),
      ),
    );

    setState(() {
      // print(emergencyContacts);
      isUserEmailAvailable = true;
    });
  }

  showUpdateBottomSheet(BuildContext context, String initialContactName) {
    showBottomSheet(
      elevation: 1,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return UpdateContactDetailsBottomSheet(
          getUpdatedContactInfo: getUpdatedContactInfo,
          initalContactName: initialContactName,
        );
      },
    );
  }

  getUpdatedContactInfo({
    required String updatedContactNum,
    required String updatedContactName,
    required String initialContactName,
  }) {
    if (emergencyContacts!.isNotEmpty) {
      emergencyContacts!.remove(initialContactName);
    }

    emergencyContacts![updatedContactName] = updatedContactNum;
    print(emergencyContacts);
    final res = UserMethods()
        .updateEmergencyContact(updatedEmergencyContacs: emergencyContacts);
    print(res);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Emergency Contacts')),
        body: !isUserEmailAvailable
            ? const CustomLoader()
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final contactItem =
                        emergencyContacts!.entries.elementAt(index);
                    final String contactName = contactItem.key;
                    final String contactNumber = contactItem.value;
                    return ContactCard(
                      index: index,
                      contactName: contactName,
                      contactNumber: contactNumber,
                      showUpdateBottomSheet: showUpdateBottomSheet,
                    );
                  },
                  itemCount: emergencyContacts!.length,
                ),
              ),
      ),
    );
  }
}
