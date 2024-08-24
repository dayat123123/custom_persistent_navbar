import 'package:custom_persistent_bottom_navbar/persistent_navbar/persistent_navbar.dart';
import 'package:custom_persistent_bottom_navbar/screen/homescreen.dart';
import 'package:custom_persistent_bottom_navbar/screen/profilscreen.dart';
import 'package:custom_persistent_bottom_navbar/screen/searchscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const PageViewTest()));
}

final _navItems = [
  BottomNavbarCustomModel(
      screen: const HomeScreen(),
      activeIcon: Icons.home_filled,
      name: 'Home',
      inactiveIcon: Icons.home),
  BottomNavbarCustomModel(
      screen: const SearchScreen(),
      activeIcon: Icons.search,
      name: 'Search',
      inactiveIcon: Icons.search),
  BottomNavbarCustomModel(
      screen: const ProfileScreen(),
      activeIcon: Icons.person,
      name: 'Profile',
      inactiveIcon: Icons.person),
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
                  return CustomPersistentNavbar(item: _navItems);
                },
              ), (route) => false);
            },
            child: const Text("Push")),
      ),
    );
  }
}
