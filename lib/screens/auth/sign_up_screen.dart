
import 'package:flutter/material.dart';
import 'package:hex_view/firebase/auth_methods.dart';
import 'package:hex_view/screens/auth/widgets/personal_details_form.dart';
import 'package:hex_view/screens/auth/widgets/signup_credentials_form.dart';
import 'package:hex_view/screens/auth/widgets/vehicle_details_form.dart';
import 'package:hex_view/shared/widgets/custom_loader.dart';


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
  Map<String, String> addedVehicles = {};
  Map<String,String> emergencyContacts = {};
  String enteredEmail = '';
  String enteredPassword = '';

  int _currentPage = 0;
  final PageController _pageController = PageController();

  getPersonalDetails({
    required String name,
    required String phone,
    required String emergencyContactName1,
    required String emergencyContactNumber1,
    required String emergencyContactName2,
    required String emergencyContactNumber2,
  }) {
    enteredName = name;
    enteredPhone = phone;
    emergencyContacts[emergencyContactName1] = emergencyContactNumber1;
    emergencyContacts[emergencyContactName2] = emergencyContactNumber2;
  }

  getVehicleDetails({required Map<String, String> vehicleNum}) {
    //will replace single vehicle_num with list of vehicle numbers
    addedVehicles = vehicleNum;
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
      addedVehicles,
      emergencyContacts,
    );
  }

  void _signUpHandler(
    String name,
    String phone,
    String email,
    String password,
    Map<String, String> vehicleNum,
    Map<String, String> emergencyContacts,
  ) async {
    FocusScope.of(context).unfocus();
    setState(() {
      _loading = true;
    });

    String res = await AuthMethods().signUpUser(
      name,
      email,
      password,
      phone,
      vehicleNum,
      emergencyContacts,
    );

    if (res == 'success') {
      await navigateToHomeScreen();
    } else {
      setState(() {
        _loading = false;
      });
    }

    if (mounted) {
      showSnackBar(res, context);
    }
  }

  navigateToHomeScreen() {
    Navigator.of(context).pop();
  }

  showSnackBar(String res, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          res,
          style: const TextStyle(color: Colors.black87),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor:
            res == 'success' ? Colors.greenAccent : Colors.redAccent,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _loading
            ? const CustomLoader()
            : Column(
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
                      physics: const NeverScrollableScrollPhysics(),
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
