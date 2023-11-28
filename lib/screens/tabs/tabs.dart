import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hex_view/firebase/user_methods.dart';
import 'package:hex_view/firebase/util_methods.dart';
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
      // print('Curr User Obj is NULL');
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
    UtilMethods().setUpPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomeScreen();

    if (selectedPageIndex == 1) {
      activePage = const QrConnectVehicleList();
    } else if (selectedPageIndex == 2) {
      activePage = AccountScreen(
        userData: userData!,
      );
    }

    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: isUserDataAvailible ? activePage : const CustomLoader(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedPageIndex,
          onTap: (index) {
            _selectedPage(index);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  FluentIcons.home_20_regular,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(
                FluentIcons.chat_20_regular,
              ),
              label: 'Requests',
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.person_20_regular),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
