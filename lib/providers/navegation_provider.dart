import 'package:flutter/material.dart';

class NavegationProvider extends ChangeNotifier {
  int _selectMenuItem = 0;
  final PageController _pageController = PageController();

  int get selecMenuItem => _selectMenuItem;
  set selecMenuItem(int index) {
    _selectMenuItem = index;
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
