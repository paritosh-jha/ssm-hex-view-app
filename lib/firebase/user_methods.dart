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
        vehicleNum: userDetails['vehicle_num'],
        name: userDetails['name'],
        phone: userDetails['phone'],
        vehicleRegNum: userDetails['vehicle_reg_num'],
        email: userDetails['email'],
        emergencyContact1: userDetails['emergency_contact1'],
        emergencyContact2:userDetails['emergency_contact2'] ,
      );
    } catch (e) {
      return null;
    }
    return currentUser;
  }
}
