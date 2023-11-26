import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hex_view/firebase/user_methods.dart';
import 'package:hex_view/model/user.dart' as model;
import 'package:hex_view/screens/splash/splash_screen.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

class EmergencyContactScreen extends StatefulWidget {
  const EmergencyContactScreen({super.key});

  @override
  State<EmergencyContactScreen> createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  late model.User? userData;
  bool isUserEmailAvailable = false;

  final TextEditingController _firstContactController = TextEditingController();
  final TextEditingController _secondContactController =
      TextEditingController();

  bool _isEditingFirstContact = false;
  bool _isEditingSecondContact = false;

  fetchEmergencyContacts() async {
    userData = await UserMethods().getUserDetails();
    if (userData == null) {
      //handle null case
      print('Curr User Obj is NULL');
      return;
    }
    setState(() {
      isUserEmailAvailable = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchEmergencyContacts();
  }

  @override
  Widget build(BuildContext context) {
    fetchEmergencyContacts();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Emergency Contacts')),
        body: !isUserEmailAvailable
            ? const SplashScreen()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContactCard(
                      label: 'Emergency Contact 1',
                      contact: userData!.emergencyContact1,
                      isEditing: _isEditingFirstContact,
                      controller: _firstContactController,
                      onEditPressed: () {
                        _toggleEditing('_isEditingFirstContact');
                      },
                      onSavePressed: () {
                        _saveContact('_firstContactController');
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildContactCard(
                      label: 'Emergency Contact 2',
                      contact: userData!.emergencyContact2,
                      isEditing: _isEditingSecondContact,
                      controller: _secondContactController,
                      onEditPressed: () {
                        _toggleEditing('_isEditingSecondContact');
                      },
                      onSavePressed: () {
                        _saveContact('_secondContactController');
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildContactCard({
    required String label,
    required String contact,
    required bool isEditing,
    required TextEditingController controller,
    required VoidCallback onEditPressed,
    required VoidCallback onSavePressed,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            if (isEditing)
              TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Enter new contact',
                ),
              )
            else
              Text(
                contact,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!isEditing)
                  TextButton(
                    onPressed: onEditPressed,
                    child: const Text('Edit'),
                  ),
                const SizedBox(width: 8),
                if (isEditing)
                  ElevatedButton(
                    onPressed: onSavePressed,
                    child: const Text('Save'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _toggleEditing(String stateVariable) {
    setState(() {
      if (stateVariable == '_isEditingFirstContact') {
        _isEditingFirstContact = !_isEditingFirstContact;
        if (_isEditingFirstContact) {
          _firstContactController.text = '';
        }
      } else if (stateVariable == '_isEditingSecondContact') {
        _isEditingSecondContact = !_isEditingSecondContact;
        if (_isEditingSecondContact) {
          _secondContactController.text = '';
        }
      }
    });
  }

  void _saveContact(String controllerVariable) async {
    String newContact = '';
    if (controllerVariable == '_firstContactController') {
      newContact = _firstContactController.text;
    } else if (controllerVariable == '_secondContactController') {
      newContact = _secondContactController.text;
    }

    // Perform the save operation (update the user data, save to database, etc.)

    // Toggle editing state after saving
    if (controllerVariable == '_firstContactController') {
      await database
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'emergency_contact1': newContact}, SetOptions(merge: true));
      _toggleEditing('_isEditingFirstContact');
    } else if (controllerVariable == '_secondContactController') {
      await database
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'emergency_contact2': newContact}, SetOptions(merge: true));
      _toggleEditing('_isEditingSecondContact');
    }
    setState(() {});
  }
}
