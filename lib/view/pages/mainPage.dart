import 'package:flutter/material.dart';
import 'package:water_tech/view/pages/home_page.dart';
import 'package:water_tech/view/pages/profile_pages.dart';
import 'package:water_tech/view/pages/settingsPage.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool active = false;
  final List<Widget> pages = [
    const HomePage(),
    const SettingsPage(),
    const ProfilePage(),
  ];

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          selectedLabelStyle: subHeadingStyleBlue,
          selectedFontSize: 17,
          unselectedFontSize: 14,
          backgroundColor: Theme.of(context).colorScheme.primary,
          currentIndex: currentPage,
          onTap: (value) {
            setState(() {
              currentPage = value;
              active = !active;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ]),
      body: pages[currentPage],
    );
  }
}
