part of 'persistent_navbar.dart';

class BottomNavbarCustom extends StatelessWidget {
  final List<BottomNavbarCustomModel> listData;
  final void Function(int) onTap;
  const BottomNavbarCustom(
      {super.key, required this.listData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: Row(
        children: [
          Container(
              width: 70, decoration: const BoxDecoration(color: Colors.blue)),
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                listData.length,
                (index) => GestureDetector(
                  onTap: () => onTap(index),
                  child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 2),
                      decoration: const BoxDecoration(color: Colors.amber),
                      child: Center(child: Text(listData[index].name))),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

class BottomNavbarCustomModel {
  final String name;
  final Widget activeIcon;
  final Widget inactiveIcon;
  final Widget screen;

  BottomNavbarCustomModel(
      {required this.name,
      required this.screen,
      required this.activeIcon,
      required this.inactiveIcon});
}
