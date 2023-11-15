import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  //SignUp user
  Future<String> signUpUser(
    String name,
    String email,
    String password,
    String phone,
    String vehicleNum,
    String vehicleRegNum,
    String emergencyContact1,
    String emergencyContact2,
  ) async {
    String res = 'Some Error Occured';
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      CollectionReference users = _firestore.collection('users');
      await users.doc(userCredential.user!.uid).set({
        "name": name,
        "email": email,
        "phone": phone,
        "vehicle_num": vehicleNum,
        "vehicle_reg_num": vehicleRegNum,
        "emergency_contact1": emergencyContact1,
        "emergency_contact2": emergencyContact2,
      });
      res = 'success';
    } on FirebaseAuthException catch (e) {
      res = e.code;
      return res;
    }
    return res;
  }

  Future<String> signInUser(String email, String password) async {
    String res = 'Some Error Occured';
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      res = 'success';
    } on FirebaseAuthException catch (e) {
      res = e.code;
    }
    return res;
  }

  Future<String> signOutUser() async {
    String res = 'Some Error Occured';
    try {
      await _auth.signOut();
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
