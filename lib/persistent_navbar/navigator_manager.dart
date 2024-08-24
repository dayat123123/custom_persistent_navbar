part of 'persistent_navbar.dart';

class NavigatorManager {
  final List<GlobalKey<NavigatorState>> _navigatorKeys;

  NavigatorManager(int tabCount)
      : _navigatorKeys =
            List.generate(tabCount, (index) => GlobalKey<NavigatorState>());

  GlobalKey<NavigatorState> getNavigatorKey(int index) {
    return _navigatorKeys[index];
  }

  void willPop(int index, {bool isPopOnce = false}) {
    final navigator = getNavigatorKey(index).currentState;
    if (isPopOnce) {
      if (navigator?.canPop() ?? false) {
        navigator?.pop();
      }
    } else {
      while (navigator?.canPop() ?? false) {
        navigator?.pop();
      }
    }
  }
}
