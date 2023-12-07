import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hex_view/model/user.dart' as model;

class UserMethods {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User?> getUserDetails() async {
    model.User? currentUser;
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      Map<String, dynamic> userDetails = doc.data() as Map<String, dynamic>;

      currentUser = model.User(
        name: userDetails['name'],
        phone: userDetails['phone'],
        email: userDetails['email'],
        vehicles: Map<String, String>.from(userDetails['vehicles'] ?? {}),
        emergencyContacts:
            Map<String, String>.from(userDetails['emergency_contacts'] ?? {}),
      );
    } catch (e) {
      return null;
    }
    return currentUser;
  }

  Future<Map<String, String>?> getEmergencyContacts() async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      Map<String, dynamic> userDetails = doc.data() as Map<String, dynamic>;

      return Map<String, String>.from(userDetails['emergency_contacts'] ?? {});
    } catch (e) {
      return null;
    }
  }

  Future<String> updateEmergencyContact(
      {required Map<String, String>? updatedEmergencyContacs}) async {
    String res = 'Something went wrong';
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update(
        {'emergency_contacts': updatedEmergencyContacs},
      );
      res = 'success';
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<Map<String, String>?> getUserVehicles() async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      Map<String, dynamic> userDetails = doc.data() as Map<String, dynamic>;

      return Map<String, String>.from(userDetails['vehicles'] ?? {});
    } catch (e) {
      return null;
    }
  }

  Future<String> addUserVehicle(
      {required Map<String, String>? vehicles}) async {
    String res = 'Something went wrong';
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update(
        {'vehicles': vehicles},
      );
      res = 'success';
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<String> updateUserVehicles(
      {required Map<String, String>? vehicles}) async {
    String res = 'Something went wrong';
    if (vehicles!.isEmpty) {
      return res;
    }
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update(
        {'vehicles': vehicles},
      );
      res = 'success';
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<String> updateUserName({required String username}) async {
    String res = 'Something went wrong';

    if (username.isEmpty) {
      return res;
    }
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update(
        {'name': username},
      );
      res = 'success';
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<String> updatePhone({required String phone}) async {
    String res = 'Something went wrong';

    if (phone.isEmpty) {
      return res;
    }
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update(
        {'phone': phone},
      );
      res = 'success';
    } catch (e) {
      return e.toString();
    }
    return res;
  }
}
