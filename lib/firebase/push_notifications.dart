import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotifications {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> setUpPushNotifications() async {
    String res = 'Some Error Occurred';
    try {
      final fcm = FirebaseMessaging.instance;
      await fcm.requestPermission();
      final token = await fcm.getToken();
      _firestore.collection('users').doc(_auth.currentUser!.uid).set(
        {'fcmToken': token},
        SetOptions(merge: true),
      );
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
