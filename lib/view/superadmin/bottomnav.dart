import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/view/superadmin/screens/pagechat/chatpage.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/hompage.dart';
import 'package:blood_donation/view/superadmin/screens/pagesettings/settings.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SuperAdminBottomNav extends StatelessWidget {
  SuperAdminBottomNav({super.key});

  final pages = [
    SuperAdminHomePage(),
    // const ChatPage(),
    const SuperAdminSettingsPage(),
  ];

  ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int index, _) {
          return pages[index];
        },
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int newIndex, _) => BottomNavigationBar(
          currentIndex: newIndex,
          onTap: (index) {
            indexChangeNotifier.value = index;
          },
          items: const [
            BottomNavigationBarItem(
                label: "Home",
                icon: Icon(
                  Icons.home_outlined,
                  color: Colours.lightRed,
                )),
            // BottomNavigationBarItem(
            //     label: "Chat",
            //     icon: Icon(
            //       Icons.chat,
            //       color: Colours.lightRed,
            //     )),
            BottomNavigationBarItem(
                label: "Settings",
                icon: Icon(
                  Icons.settings,
                  color: Colours.lightRed,
                ))
          ],
        ),
      ),
    );
  }
}
