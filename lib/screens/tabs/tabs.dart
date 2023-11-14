import 'package:flutter/material.dart';
import 'package:hex_view/screens/home/home.dart';
import 'package:hex_view/screens/qr_connect/qr_connect.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedPageIndex = 0;
  void _selectedPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomeScreen();
    String activePageTitle = 'Hex Zone';

    if (selectedPageIndex == 1) {
      activePage = const QRConnectScreen();
      activePageTitle = 'QR Connect';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPageIndex,
        showUnselectedLabels: false,
        onTap: (index) {
          _selectedPage(index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.card_membership_outlined,
              ),
              label: 'Car'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QR'),
        ],
      ),
    );
  }
}
