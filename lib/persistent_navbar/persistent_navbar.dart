import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'navigator_manager.dart';
part 'bottom_navbar.dart';
part 'bottom_navbar_model.dart';
part 'bottom_navbar_enum.dart';
part 'persistent_navbar_controller.dart';

class PersistentNavbar extends StatefulWidget {
  final List<BottomNavbarCustomModel> item;
  final void Function(int)? onTabSelected;
  final double iconSize;
  final void Function(int)? onTapLastFixItem;
  final double widthItem;
  final bool withText;
  final NavbarStyle navbarStyle;
  final PersistentNavbarController? controller;

  const PersistentNavbar({
    super.key,
    required this.item,
    this.onTabSelected,
    this.iconSize = 25,
    this.widthItem = 90,
    this.withText = true,
    this.navbarStyle = NavbarStyle.style1,
    this.onTapLastFixItem,
    this.controller,
  }) : assert(item.length >= 2, 'item must contain at least 2 items');

  @override
  State<PersistentNavbar> createState() => _PersistentNavbarState();
}

class _PersistentNavbarState extends State<PersistentNavbar> {
  late final PersistentNavbarController _controller;
  late final NavigatorManager _navigatorManager;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        PersistentNavbarController(length: widget.item.length);
    _navigatorManager = NavigatorManager(widget.item.length);
    _controller.initializePage(_controller.index);
    _controller.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (!_controller.isPageInitialized[_controller.index]) {
      _controller.initializePage(_controller.index);
    }
    setState(() {
      if (widget.onTabSelected != null) {
        widget.onTabSelected!(_controller.index);
      }
    });
  }

  void _onItemTapped(int index) {
    if (_controller.index == index) {
      _willPopScope();
    } else {
      _controller.jumpToTab(index);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTabChanged);
    super.dispose();
  }

  void _willPopScope({bool isPopOnce = false}) {
    _navigatorManager.willPop(_controller.index, isPopOnce: isPopOnce);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) => _willPopScope(isPopOnce: true),
        child: Scaffold(
            body: IndexedStack(
              index: _controller.index,
              children: List.generate(
                widget.item.length,
                (index) => _buildScreen(index),
              ),
            ),
            bottomNavigationBar: BottomNavbar(
                selectedIndex: _controller.index,
                listData: widget.item,
                onTap: _onItemTapped,
                iconSize: widget.iconSize,
                widthItem: widget.widthItem,
                navbarStyle: widget.navbarStyle,
                withText: widget.withText,
                onTapLastItemCustom: widget.onTapLastFixItem)));
  }

  Widget _buildScreen(int index) {
    if (_controller.isPageInitialized[index]) {
      return Navigator(
          key: _navigatorManager.getNavigatorKey(index),
          onGenerateRoute: (settings) => CupertinoPageRoute(
              builder: (context) => widget.item[index].screen,
              settings: settings));
    } else {
      return const SizedBox.shrink();
    }
  }
}
