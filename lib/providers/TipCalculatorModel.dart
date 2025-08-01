// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/widgets.dart';

class TipCalculatorModel with ChangeNotifier{
  int _personCount = 1;
  double _tipPecentage = 0.0;
  double _billTotal = 0.0;

  double get tipPercentage => _tipPecentage;
  double get billTotal => _billTotal;
  int get personCount => _personCount;
  

  void updateBillTotal(double billTotal) {
    _billTotal = billTotal;
    notifyListeners();
  }

  void updateTipPercentage(double tipPercentage) {
    _tipPecentage = tipPercentage;
    notifyListeners();
  }

  void updatePersonCount(int personCount) {
    _personCount = personCount;
    notifyListeners();
  }

  double get totalPerPerson => ((_billTotal * _tipPecentage) + _billTotal) / _personCount;
}