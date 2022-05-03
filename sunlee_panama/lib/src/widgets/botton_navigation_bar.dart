import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/providers/navigation_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list_alt),
      label: 'Balance',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Perfil',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    var navigation = Provider.of<NavigationProvider>(context, listen: true);
    return BottomNavigationBar(
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      currentIndex: navigation.currentIndex,
      backgroundColor: Colors.grey[100],
      items: items,
      onTap: (index) {
        if (index >= 0 ||
            index != navigation.currentIndex ||
            index < items.length - 1) {
          navigation.currentIndexUpdate = index;
        } else {
          navigation.currentIndexUpdate = 0;
        }
      },
    );
  }
}
