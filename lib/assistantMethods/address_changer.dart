import 'package:flutter/cupertino.dart';
// GO TO MAIN AND ADD THE notifier provider
class AddressChanger extends ChangeNotifier
{
  int _counter = 0;
  int get count => _counter;

  displayResult(dynamic newValue)
  {
    _counter = newValue;
    notifyListeners();
  }
}