import 'package:flutter/material.dart';

class RevokeProvider extends ChangeNotifier {

  final List<String> _list = [];

  void put(String json) {
    _list.add(json);
    notifyListeners();
  }

  void clear() {
    _list.clear();
    notifyListeners();
  }

  bool isEmpty() => _list.isEmpty;

  List<String> get list => _list;
}