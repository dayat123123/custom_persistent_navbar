import 'package:custom_persistent_bottom_navbar/persistent_navbar/persistent_navbar.dart';
import 'package:custom_persistent_bottom_navbar/screen/homescreen.dart';
import 'package:custom_persistent_bottom_navbar/screen/profilscreen.dart';
import 'package:custom_persistent_bottom_navbar/screen/searchscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: PageViewTest()));
}

final _navItems = [
  BottomNavbarCustomModel(
      screen: const HomeScreen(),
      activeIcon: const Icon(Icons.home_filled),
      name: 'Home',
      inactiveIcon: const Icon(Icons.home)),
  BottomNavbarCustomModel(
      screen: const SearchScreen(),
      activeIcon: const Icon(Icons.search),
      name: 'Search',
      inactiveIcon: const Icon(Icons.search)),
  BottomNavbarCustomModel(
      screen: const ProfileScreen(),
      activeIcon: const Icon(Icons.person),
      name: 'Profile',
      inactiveIcon: const Icon(Icons.person)),
];

class PageViewTest extends StatelessWidget {
  const PageViewTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  CupertinoPageRoute(
                builder: (context) {
                  return CustomPersistentNavbar(
                      item: _navItems,
                      onTabSelected: (p0) {
                        print(p0);
                      });
                },
              ), (route) => false);
            },
            child: const Text("Push")),
      ),
    );
  }
}
