import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 0;
  /* PageController _pageController = PageController(
    initialPage: 0,
    keepPage: false,
  ); */

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    /* _pageController.animateToPage(value,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut); */
    notifyListeners();
  }

  set currentIndexUpdate(int value) {
    //print('pagina: $value');
    _currentIndex = value;
    /* _pageController.animateToPage(value,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut); */
    notifyListeners();
  }

  //PageController get pageController => _pageController;
}
