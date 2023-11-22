import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hex_view/firebase/user_methods.dart';
import 'package:hex_view/screens/account/account_screen.dart';
import 'package:hex_view/screens/home/home.dart';
import 'package:hex_view/model/user.dart' as model;
import 'package:hex_view/screens/qr_connect/qr_connect.dart';
import 'package:hex_view/shared/widgets/custom_loader.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedPageIndex = 0;
  bool isUserDataAvailible = false;
  late model.User? userData;

  void _selectedPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void fetchUserData() async {
    userData = await UserMethods().getUserDetails();
    if (userData == null) {
      //handle null case
      print('Curr User Obj is NULL');
      return;
    }
    setState(() {
      isUserDataAvailible = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomeScreen();
    String activePageTitle = 'Hex Zone';

    if (selectedPageIndex == 1) {
      activePage = const QrConnectVehicleList();
      activePageTitle = 'QR Connect';
    } else if (selectedPageIndex == 2) {
      activePage = AccountScreen(userData: userData!,);
      activePageTitle = 'Account';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: isUserDataAvailible ? activePage : const CustomLoader()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPageIndex,
        onTap: (index) {
          _selectedPage(index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
