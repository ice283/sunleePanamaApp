import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  int get currentIndex => _currentIndex;


  set currentIndexUpdate(int value) {
    _currentIndex = value;
    _pageController.animateToPage(value,
        duration: Duration(milliseconds: 150), curve: Curves.easeInOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
