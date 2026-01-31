import 'package:flutter/material.dart';

class BottomNavBarItem {
  final IconData icon;
  final IconData? selectedIcon;
  final String label;

  const BottomNavBarItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
  });
}

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final List<BottomNavBarItem> items;
  final ValueChanged<int>? onTap;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.items,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) => onTap?.call(index),
      destinations: items
          .map(
            (item) => NavigationDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.selectedIcon ?? item.icon),
              label: item.label,
            ),
          )
          .toList(),
    );
  }
}

