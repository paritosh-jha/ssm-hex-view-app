import 'package:flutter/material.dart';
import 'package:hex_view/firebase/user_methods.dart';
import 'package:hex_view/screens/account/account_screen.dart';
import 'package:hex_view/screens/home/home.dart';
import 'package:hex_view/screens/qr_connect/qr_connect.dart';
import 'package:hex_view/model/user.dart' as model;

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedPageIndex = 0;
  bool isUserDataAvailible = false;
  void _selectedPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void fecthUserData() async {
    model.User? currentUserData = await UserMethods().getUserDetails();

    if (currentUserData == null) {
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
    fecthUserData();
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomeScreen();
    String activePageTitle = 'Hex Zone';

    if (selectedPageIndex == 1) {
      activePage = const QRConnectScreen();
      activePageTitle = 'QR Connect';
    } else if (selectedPageIndex == 2) {
      activePage = const AccountScreen();
      activePageTitle = 'Account';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: isUserDataAvailible
            ? activePage
            : const Center(child: CircularProgressIndicator()),
      ),
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
