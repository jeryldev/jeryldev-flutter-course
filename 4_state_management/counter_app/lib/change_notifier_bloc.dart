import 'package:flutter/material.dart';

class ChangeNotifierBloc extends ChangeNotifier{
  double counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }

  void decrement() {
    counter--;
    notifyListeners();
  }
}