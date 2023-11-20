import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hex_view/firebase/auth_methods.dart';
import 'package:hex_view/screens/auth/widgets/personal_details_form.dart';
import 'package:hex_view/screens/auth/widgets/signup_credentials_form.dart';
import 'package:hex_view/screens/auth/widgets/vehicle_details_form.dart';
import 'package:hex_view/screens/tabs/tabs.dart';

final _firebase = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // ignore: unused_field
  bool _loading = false;
  String enteredName = '';
  String enteredPhone = '';
  List<String> addedVehicleNums = [];
  String enteredEmergencyContact1 = '';
  String enteredEmergencyContact2 = '';
  String enteredEmail = '';
  String enteredPassword = '';

  int _currentPage = 0;
  final PageController _pageController = PageController();

  getPersonalDetails({
    required String name,
    required String phone,
    required String emergencyContact1,
    required String emergencyContact2,
  }) {
    enteredName = name;
    enteredPhone = phone;
    enteredEmergencyContact1 = enteredEmergencyContact1;
    enteredEmergencyContact2 = enteredEmergencyContact2;
  }

  getVehicleDetails({required List<String> vehicleNum}) {
    //will replace single vehicle_num with list of vehicle numbers
    addedVehicleNums = vehicleNum;
  }

  getSignUpCredentials({
    required String email,
    required String password,
  }) {
    enteredEmail = email;
    enteredPassword = password;

    //SIGN UP USER HERE
    _signUpHandler(
      enteredName,
      enteredPhone,
      enteredEmail,
      enteredPassword,
      addedVehicleNums,
      enteredEmergencyContact1,
      enteredEmergencyContact2,
    );
    Navigator.pop(context);
  }

  void _signUpHandler(
    String name,
    String phone,
    String email,
    String password,
    List<String> vehicleNum,
    String emergencyContact1,
    String emergencyContact2,
  ) async {
    setState(() {
      _loading = true;
    });

    String res = await AuthMethods().signUpUser(
      name,
      email,
      password,
      phone,
      vehicleNum,
      emergencyContact1,
      emergencyContact2,
    );
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
    // print(res);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              value: (_currentPage + 1) / 3,
              color: Colors.black87,
            ),
            const Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  'Become a member!',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: PageView(
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                controller: _pageController,
                // physics: const NeverScrollableScrollPhysics(),
                children: [
                  PersonalDetailsForm(
                    pageController: _pageController,
                    getPersonalDetails: getPersonalDetails,
                  ),
                  VehicleDetailsForm(
                    pageController: _pageController,
                    getVehicleDetails: getVehicleDetails,
                  ),
                  SignUpCredentialsForm(
                    pageController: _pageController,
                    getSignUpCredentials: getSignUpCredentials,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
