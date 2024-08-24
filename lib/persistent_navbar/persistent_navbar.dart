import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'navigator_manager.dart';
part 'bottom_navbar.dart';
part 'bottom_navbar_model.dart';

class CustomPersistentNavbar extends StatefulWidget {
  final List<BottomNavbarCustomModel> item;
  final void Function(int)? onTabSelected;

  const CustomPersistentNavbar(
      {super.key, required this.item, this.onTabSelected})
      : assert(item.length >= 2, 'item must contain at least 2 items');

  @override
  State<CustomPersistentNavbar> createState() => _CustomPersistentNavbarState();
}

class _CustomPersistentNavbarState extends State<CustomPersistentNavbar> {
  int _selectedIndex = 0;
  late final NavigatorManager _navigatorManager;
  late final List<bool> _isPageInitialized;

  @override
  void initState() {
    super.initState();
    print("Init persistent navbar");
    _navigatorManager = NavigatorManager(widget.item.length);
    _isPageInitialized = List<bool>.filled(widget.item.length, false);
    _isPageInitialized[_selectedIndex] = true;
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
        _isPageInitialized[index] = true;
        if (widget.onTabSelected != null) widget.onTabSelected!(index);
      });
    } else {
      _willPopScope();
    }
  }

  void _willPopScope({bool isPopOnce = false}) {
    _navigatorManager.willPop(_selectedIndex, isPopOnce: isPopOnce);
  }

  @override
  void dispose() {
    print("Dispose persistent navbar");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) => _willPopScope(isPopOnce: true),
        child: Scaffold(
            body: IndexedStack(
                index: _selectedIndex,
                children: List.generate(
                    widget.item.length, (index) => _buildScreen(index))),
            bottomNavigationBar: BottomNavbarCustom(
                selectedIndex: _selectedIndex,
                listData: widget.item,
                onTap: _onItemTapped)));
  }

  Widget _buildScreen(int index) => _isPageInitialized[index]
      ? Navigator(
          key: _navigatorManager.getNavigatorKey(index),
          onGenerateRoute: (settings) => CupertinoPageRoute(
              builder: (context) => widget.item[index].screen,
              settings: settings))
      : const SizedBox.shrink();
}
