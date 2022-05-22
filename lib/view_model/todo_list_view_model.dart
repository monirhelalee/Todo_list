import 'package:flutter/material.dart';

class ToDoListViewModel extends ChangeNotifier {
  int _selectedPageNo = 0;
  set selectedPageNo(int v) {
    _selectedPageNo = v;
    notifyListeners();
  }

  int get selectedPageNo => _selectedPageNo;
}
