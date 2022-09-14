import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodie_users/assistantMethods/cart_item_counter.dart';
import 'package:foodie_users/global/global.dart';
import 'package:provider/provider.dart';


//don't allow repetitive addings of the same item to the database
separateItemIDs(){
  List<String> separateItemIDsList=[], defaultItemList=[];
  int i=0;
  defaultItemList = sharedPreferences!.getStringList("userCart")!;
  for(i; i< defaultItemList.length; i++){
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");
    String getItemId = (pos != -1) ? item.substring(0, pos):item;
    print("\n This is the itemID now= " + getItemId);
    separateItemIDsList.add(getItemId); //prevent to add multiple times
  }
  print("\nThis is Items List now =");
  print(separateItemIDsList);
  return separateItemIDsList;
}

addItemToCart(String? foodItemId, BuildContext context, int itemCounter){
  List<String>? tempList = sharedPreferences!.getStringList("userCart");
  tempList!.add(foodItemId! + ":$itemCounter"); //this is the format of the database id: 342432323:2

  FirebaseFirestore.instance.collection("users")
    .doc(firebaseAuth.currentUser!.uid).update({
      "userCart": tempList,
    }).then((value)
    {
      // add fluttertoast dependency
      Fluttertoast.showToast(msg: "Item Added Successfully"); // pop-up message
      sharedPreferences!.setStringList("userCart", tempList);

      //update the badge
      Provider.of<CartItemCounter>(context, listen: false).displayCartListItemsNumber();
      
    });
}

separateItemQuantities(){
  List<int> separateItemQuantityList=[];
  List<String> defaultItemList=[];
  int i=1;
  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i< defaultItemList.length; i++){

    String item = defaultItemList[i].toString();

    List<String> listItemCharacters = item.split(":").toList();

    var quanNumber = int.parse(listItemCharacters[1].toString());

    print("\n This is Quantify Number= " + quanNumber.toString());
    separateItemQuantityList.add(quanNumber);
  }

  print("\nThis is Items List now =");
  print(separateItemQuantityList);
  return separateItemQuantityList;
}