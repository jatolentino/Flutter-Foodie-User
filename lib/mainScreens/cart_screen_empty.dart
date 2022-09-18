import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodie_users/assistantMethods/assistant_methods.dart';
import 'package:foodie_users/assistantMethods/cart_item_counter.dart';
import 'package:foodie_users/assistantMethods/total_amount.dart';
import 'package:foodie_users/mainScreens/address_screen.dart';
import 'package:foodie_users/models/items.dart';
import 'package:foodie_users/splashScreen/splash_screen.dart';
import 'package:foodie_users/widgets/app_bar.dart';
import 'package:foodie_users/widgets/cart_item_design.dart';
import 'package:foodie_users/widgets/progress_bar.dart';
import 'package:foodie_users/widgets/text_widget_header.dart';
import 'package:provider/provider.dart';

class CartScreenSimple extends StatefulWidget {
  
  final String? sellerUID;
  CartScreenSimple({this.sellerUID});

  @override
  _CartScreenSimpleState createState() => _CartScreenSimpleState();
}

class _CartScreenSimpleState extends State<CartScreenSimple> {
  List<int>? separateItemQuantityList;
  num totalAmount = 0;

  @override
  void initState() {
    super.initState();
    //separateItemQuantities();

    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(0); //// ADDING THE FUNCTION from total_amount.dart
    separateItemQuantityList = separateItemQuantities();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: //MyAppBar(sellerUID: widget.sellerUID), this is sending to the cartsecrren (arrow_back button)
      AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient( //const linearGradient
              colors: [
                Colors.pink.shade400,
                Colors.red.shade400,
              ],
              begin: const FractionalOffset(0.0, 0.5),
              end: const FractionalOffset(1.0, 0.5),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.clear_all), //////// IT WAS Icons.arrow_back
          onPressed: (){
            clearCartNow(context);  ////// SO WHEN YOU GO BACK, THE CART IS CLEARED
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
            Fluttertoast.showToast(msg: "Cart has been cleared.");
          },
        ),
        title: const Text(
          "Foodie",
          style: TextStyle(fontSize: 35, fontFamily: "Signatra"), //Lobster
        ),
        centerTitle: true,
        //automaticallyImplyLeading: false,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: (){
                // send user to cart screen
                  //Navigator.push(context, MaterialPageRoute(builder: (c)=> CartScreenSimple(sellerUID: widget.sellerUID)));
                  //clickeds
                  print("clicked");
                },
              ),
              Positioned(
                child: Stack(
                  children: [
                    const Icon(
                      Icons.brightness_1,
                      size: 20.0,
                      color: Colors.green,
                    ),
                    Positioned(
                      top:3,
                      right: 4,
                      child: Center(
                        //child: Text("0", style: TextStyle(color: Colors.white, fontSize: 12),),
                        child: Consumer<CartItemCounter>(
                          builder: (context, counter, c){
                            return Text(
                              counter.count.toString(),
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(width: 8,),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              label: const Text("Clear Cart", style: TextStyle(fontSize: 16),),
              backgroundColor: Colors.red,
              icon: const Icon(Icons.clear_all),
              heroTag: "btn1",
              onPressed: (){
                clearCartNow(context);
                Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));

                Fluttertoast.showToast(msg: "Cart has been cleared.");
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              label: const Text("Check Out", style: TextStyle(fontSize: 16,),),
              backgroundColor: Colors.red,
              icon: const Icon(Icons.navigate_next),
              heroTag: "btn2",
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (c) => AddressScreen(
                  totalAmount: totalAmount.toDouble(),
                  sellerUID: widget.sellerUID,
                )));
              },
            ),
          ),

        ],
      ),
    );
  }}