import 'package:custom_persistent_bottom_navbar/persistent_navbar/persistent_navbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: PageView()));
}

final List<Widget> _pages = [
  const HomeScreen(),
  const SearchScreen(),
  const ProfileScreen(),
];
final _navItems = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.search),
    label: 'Search',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'Profile',
  ),
];

class PageView extends StatelessWidget {
  const PageView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPersistentNavbar(
      item: _navItems,
      screen: _pages,
      onTabSelected: (p0) {
        print(p0);
      },
    );
  }
}
