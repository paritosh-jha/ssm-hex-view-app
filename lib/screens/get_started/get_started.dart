import 'package:flutter/material.dart';
import 'package:hex_view/screens/auth/login_screen.dart';
import 'package:hex_view/screens/auth/sign_up_screen.dart';
import 'package:hex_view/shared/widgets/custom_button.dart';
import 'package:transparent_image/transparent_image.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInImage(
                  height: 400,
                  fadeInDuration: const Duration(milliseconds: 300),
                  placeholder: MemoryImage(kTransparentImage),
                  image: const AssetImage('assets/images/get_started.jpg'),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextIconButton(
                        label: 'Get started',
                        icon: const Icon(Icons.arrow_right_alt),
                        onpressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        outlined: false,
                        iconColor: Colors.white,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextButton(
                        label: 'Already a user? Sign in',
                        onpressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        outlined: true,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
