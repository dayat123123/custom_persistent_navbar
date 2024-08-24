import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
part 'navigator_manager.dart';

class CustomPersistentNavbar extends StatefulWidget {
  final List<BottomNavigationBarItem> item;
  final List<Widget> screen;
  final void Function(int)? onTabSelected;
  const CustomPersistentNavbar({
    super.key,
    required this.item,
    required this.screen,
    this.onTabSelected,
  });

  @override
  State<CustomPersistentNavbar> createState() => _CustomPersistentNavbarState();
}

class _CustomPersistentNavbarState extends State<CustomPersistentNavbar> {
  int _selectedIndex = 0;
  late NavigatorManager _navigatorManager;

  @override
  void initState() {
    super.initState();
    _navigatorManager = NavigatorManager(widget.screen.length);
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
        if (widget.onTabSelected != null) widget.onTabSelected!(_selectedIndex);
      });
    } else {
      _willPopScope();
    }
  }

  void _willPopScope() {
    _navigatorManager.willPop(_selectedIndex);
  }

  @override
  void dispose() {
    print("Dispose");
    _navigatorManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) => _willPopScope(),
        child: Scaffold(
            body: IndexedStack(
                index: _selectedIndex,
                children: widget.screen
                    .asMap()
                    .map((index, page) => MapEntry(
                        index,
                        Navigator(
                            key: _navigatorManager.getNavigatorKey(index),
                            onGenerateRoute: (settings) {
                              return CupertinoPageRoute(
                                  builder: (context) => page,
                                  settings: settings);
                            })))
                    .values
                    .toList()),
            bottomNavigationBar: Theme(
                data: ThemeData(
                    splashFactory: NoSplash.splashFactory,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent),
                child: BottomNavigationBar(
                    items: widget.item,
                    currentIndex: _selectedIndex,
                    onTap: _onItemTapped))));
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const WidgetTest()));
              },
              child: const Text('Home Page'))),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Center(
          child: GestureDetector(
              onTap: () {
                // showModalBottomSheet(
                //   useRootNavigator: true,
                //   context: context,
                //   builder: (context) => DraggableScrollableSheet(
                //     builder: (context, scrollController) {
                //       return Container();
                //     },
                //   ),
                // );

                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(builder: (context) => NewPage()),
                );
              },
              child: Text('Search Page'))),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const WidgetTest()));
              },
              child: Text('Profile Page'))),
    );
  }
}

class WidgetTest extends StatefulWidget {
  const WidgetTest({super.key});

  @override
  State<WidgetTest> createState() => _WidgetTestState();
}

class _WidgetTestState extends State<WidgetTest> {
  @override
  void initState() {
    print("Init");
    super.initState();
  }

  @override
  void dispose() {
    print("Dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const WidgetTest()));
              },
              child: Text('Profile Page'))),
    );
  }
}

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
