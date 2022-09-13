import 'package:flutter/cupertino.dart';
import 'package:foodie_users/global/global.dart';

class CartItemCounter extends ChangeNotifier{
  int cartListItemCounter = sharedPreferences!.getStringList("userCart")!.length -1;
  int get count => cartListItemCounter;

  Future<void> displayCartListItemsNumber() async{
    cartListItemCounter = sharedPreferences!.getStringList("userCart")!.length -1;

    await Future.delayed(const Duration(milliseconds: 100), (){
      notifyListeners();
    });
  }
}