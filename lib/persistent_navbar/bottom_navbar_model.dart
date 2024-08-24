part of 'persistent_navbar.dart';

class BottomNavbarCustomModel {
  final String name;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final Widget screen;

  BottomNavbarCustomModel({
    required this.name,
    required this.screen,
    required this.activeIcon,
    required this.inactiveIcon,
  });
}
