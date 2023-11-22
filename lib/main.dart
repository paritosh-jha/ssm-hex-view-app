import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hex_view/firebase_options.dart';
import 'package:hex_view/screens/get_started/get_started.dart';
import 'package:hex_view/screens/splash/splash_screen.dart';
import 'package:hex_view/screens/tabs/tabs.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hex View',
      theme: ThemeData().copyWith(
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.latoTextTheme(),
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: Colors.black87),
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black87,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.blueGrey.shade200,
                width: 2,
              ),
            ),
            labelStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
          textButtonTheme: const TextButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black87),
                foregroundColor: MaterialStatePropertyAll(Colors.white)),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.black87,
            showUnselectedLabels: false,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.black87)),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else if (snapshot.hasData) {
            return const TabsScreen();
          } else {
            return const GetStartedScreen();
          }
        },
      ),
    );
  }
}
