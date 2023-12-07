import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hex_view/firebase/user_methods.dart';
import 'package:hex_view/firebase/push_notifications.dart';
import 'package:hex_view/screens/account/account_screen.dart';
import 'package:hex_view/screens/home/home.dart';
import 'package:hex_view/model/user.dart' as model;
import 'package:hex_view/screens/qr_requests/qr_requests.dart';
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
    PushNotifications().setUpPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = HomeScreen(
      vehicles: userData!.vehicles,
    );

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
          backgroundColor: Colors.white,
          elevation: 0,
          currentIndex: selectedPageIndex,
          onTap: (index) {
            _selectedPage(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                selectedPageIndex == 0
                    ? FluentIcons.home_20_filled
                    : FluentIcons.home_20_regular,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                selectedPageIndex == 1
                    ? FluentIcons.chat_20_filled
                    : FluentIcons.chat_20_regular,
              ),
              label: 'Requests',
            ),
            BottomNavigationBarItem(
              icon: Icon(selectedPageIndex == 2
                  ? FluentIcons.person_20_filled
                  : FluentIcons.person_20_regular),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
