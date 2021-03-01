import 'package:flutter/material.dart';

import '../models/models.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  const TabSelector(
      {@required this.activeTab, @required this.onTabSelected, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      backgroundColor: Colors.white,
      items: AppTab.values
          .map((tab) => BottomNavigationBarItem(
              icon: _tabIcon(tab), label: _tabLabel(tab)))
          .toList());

  Icon _tabIcon(AppTab tab) {
    switch (tab) {
      case AppTab.public:
        return const Icon(Icons.show_chart);
        break;
      case AppTab.favourites:
        return const Icon(Icons.favorite_outline);
        break;
      case AppTab.private:
        return const Icon(Icons.lock_outline);
        break;

      default:
        return const Icon(Icons.show_chart);
        break;
    }
  }

  String _tabLabel(AppTab tab) {
    switch (tab) {
      case AppTab.public:
        return 'All';
        break;
      case AppTab.favourites:
        return 'Favorites';
        break;
      case AppTab.private:
        return 'Private';
        break;

      default:
        return 'All';
        break;
    }
  }
}
