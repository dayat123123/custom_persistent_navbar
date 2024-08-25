part of 'persistent_navbar.dart';

class BottomNavbar extends StatelessWidget {
  final List<BottomNavbarCustomModel> listData;
  final void Function(int)? onTap;
  final void Function(int)? onTapLastItemCustom;
  final int selectedIndex;
  final double widthItem;
  final bool withText;
  final double iconSize;
  final NavbarStyle navbarStyle;

  const BottomNavbar({
    super.key,
    required this.listData,
    required this.onTap,
    required this.selectedIndex,
    required this.navbarStyle,
    required this.widthItem,
    required this.withText,
    required this.iconSize,
    this.onTapLastItemCustom,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.25,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
      child: BottomAppBar(
        elevation: 0,
        padding: const EdgeInsets.only(top: 5),
        color: Colors.transparent,
        height: kBottomNavigationBarHeight,
        child: _navbarStyleWidget(context),
      ),
    );
  }

  Widget _navbarStyleWidget(BuildContext context) {
    final double adjustedIconSize = withText ? iconSize : iconSize + 3;
    switch (navbarStyle) {
      case NavbarStyle.style1:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(listData.length, (index) {
            return _navItem(
              context,
              index,
              listData[index],
              iconSize: adjustedIconSize,
            );
          }),
        );
      case NavbarStyle.style2:
      default:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _navItem(context, 0, listData[0], iconSize: adjustedIconSize),
            Expanded(child: _scrollingNavItems(context, adjustedIconSize)),
            _navItem(
              context,
              listData.length - 1,
              listData.last,
              iconSize: adjustedIconSize,
              isLastItem: true,
            ),
          ],
        );
    }
  }

  Widget _scrollingNavItems(BuildContext context, double iconSize) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          listData.length - 2,
          (index) {
            final actualIndex = index + 1;
            return _navItem(
              context,
              actualIndex,
              listData[actualIndex],
              iconSize: iconSize,
            );
          },
        ),
      ),
    );
  }

  Widget _navItem(BuildContext context, int index, BottomNavbarCustomModel data,
      {double? iconSize, bool isLastItem = false}) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: InkWell(
        onTap: () {
          if (isLastItem && onTapLastItemCustom != null) {
            onTapLastItemCustom?.call(index);
          } else {
            onTap?.call(index);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: widthItem,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: selectedIndex == index ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  data.activeIcon,
                  color: _color(index),
                  size: iconSize,
                ),
              ),
              if (withText) Text(data.name, style: _textStyle(index)),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _textStyle(int index) =>
      TextStyle(color: _color(index), fontSize: 13);

  Color? _color(int index) => selectedIndex == index ? Colors.blue : null;
}
