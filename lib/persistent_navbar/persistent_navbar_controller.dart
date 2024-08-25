part of 'persistent_navbar.dart';

class PersistentNavbarController extends ChangeNotifier {
  PersistentNavbarController({required int length, final int initialIndex = 0})
      : _index = initialIndex,
        _isPageInitialized = List<bool>.filled(length, false),
        assert(initialIndex >= 0, "Value cannot be less than zero");

  int _index;
  final List<bool> _isPageInitialized;

  int get index => _index;

  List<bool> get isPageInitialized => _isPageInitialized;

  set index(final int value) {
    assert(value >= 0, "Value cannot be less than zero");
    if (_index != value) {
      _index = value;
      _isPageInitialized[value] = true;
      notifyListeners();
    }
  }

  void jumpToTab(final int value) {
    index = value;
  }

  void initializePage(int value) {
    if (!_isPageInitialized[value]) {
      _isPageInitialized[value] = true;
      notifyListeners();
    }
  }
}
