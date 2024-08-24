part of 'persistent_navbar.dart';

class NavigatorManager {
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [];

  NavigatorManager(int tabCount) {
    for (int i = 0; i < tabCount; i++) {
      _navigatorKeys.add(GlobalKey<NavigatorState>());
    }
  }

  GlobalKey<NavigatorState> getNavigatorKey(int index) {
    return _navigatorKeys[index];
  }

  void willPop(int index) {
    final navigator = getNavigatorKey(index).currentState;
    while (navigator?.canPop() ?? false) {
      navigator?.pop();
    }
  }

  void dispose() {
    _navigatorKeys.clear();
  }
}
