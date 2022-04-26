import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int _currentIndex;
  CustomNavigationBar(
    this._currentIndex, {
    Key? key,
  }) : super(key: key);

  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: 'Carrito',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list_alt),
      label: 'Pedidos',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Perfil',
    ),
  ];
  final List<String> _routes = [
    '/home',
    '/cart',
    '/orders',
    '/profile',
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.black26,
      showUnselectedLabels: true,
      currentIndex: _currentIndex,
      backgroundColor: Colors.white30,
      type: BottomNavigationBarType.shifting,
      items: items,
      onTap: (index) {
        if (_currentIndex != index) {
          Navigator.pushReplacementNamed(context, _routes[index]);
        }
      },
    );
  }
}
