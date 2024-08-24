part of 'persistent_navbar.dart';

class BottomNavbarCustom extends StatelessWidget {
  final List<BottomNavbarCustomModel> listData;
  final void Function(int) onTap;
  final void Function()? onTapOrder;
  final int selectedIndex;

  const BottomNavbarCustom({
    super.key,
    required this.listData,
    required this.onTap,
    required this.selectedIndex,
    this.onTapOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 7.5),
      alignment: Alignment.topCenter,
      height: kBottomNavigationBarHeight + (Platform.isIOS ? 25 : 0),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: 0.25, color: Colors.grey.withOpacity(0.5)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _homeWidget(),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(listData.length - 1, (index) {
                    final actualIndex = index + 1;
                    final data = listData[actualIndex];
                    return _customWidget(actualIndex, data);
                  })))),
          _orderWidget()
        ],
      ),
    );
  }

  Widget _homeWidget() {
    return GestureDetector(
        onTap: () => onTap(0),
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 90,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedScale(
                    scale: selectedIndex == 0 ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(listData[0].activeIcon, color: _color(0)),
                  ),
                  Text(listData[0].name, style: _textStyle(0))
                ])));
  }

  Widget _customWidget(int actualIndex, BottomNavbarCustomModel data) {
    return GestureDetector(
        onTap: () => onTap(actualIndex),
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 90,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedScale(
                    scale: selectedIndex == actualIndex ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(data.activeIcon, color: _color(actualIndex)),
                  ),
                  Text(data.name, style: _textStyle(actualIndex))
                ])));
  }

  Widget _orderWidget() {
    return GestureDetector(
        onTap: onTapOrder,
        child: const SizedBox(
            width: 80,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag),
                  Text("Order", style: TextStyle(fontSize: 13))
                ])));
  }

  TextStyle _textStyle(int index) =>
      TextStyle(color: _color(index), fontSize: 13);

  Color? _color(int index) => selectedIndex == index ? Colors.blue : null;
}
