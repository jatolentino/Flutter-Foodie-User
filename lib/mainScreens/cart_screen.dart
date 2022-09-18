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

class CartScreen extends StatefulWidget {
  
  final String? sellerUID;
  CartScreen({this.sellerUID});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
                  //Navigator.push(context, MaterialPageRoute(builder: (c)=> CartScreen(sellerUID: widget.sellerUID)));
                  //clickeds
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
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true, 
            delegate: TextWidgetHeader(title: "My Cart List "),//"Total amount 120"),
          ),

          SliverToBoxAdapter(
            child: Consumer2<TotalAmount, CartItemCounter>(builder: (context, amountProvider, cartProvider, c)
            {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: cartProvider.count == 0
                  ? Container ()
                  : Text(
                    "Total Price \$ " + amountProvider.tAmount.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )
                  )
                )
              );
            }),
          ),

          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
              .collection("items")
              .where("itemID", whereIn: separateItemIDs())
              .orderBy("publishedDate", descending: false) //was false, set to true both descending with my_orders_screen line 28
              .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
              ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
              : snapshot.data!.docs.length == 0
              ?
              Container()
              : SliverList(
                delegate: SliverChildBuilderDelegate((context, index){
                  Items model = Items.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  );
                  
                  if(index == 0){
                    totalAmount = 0;
                    totalAmount = totalAmount + model.price! * separateItemQuantityList![index]; //#*price
                  }

                  else{
                    totalAmount = totalAmount + model.price! * separateItemQuantityList![index]; //#*price
                  }

                  if(snapshot.data!.docs.length -1 == index){ //substract the gargabe constant from database = last index/iteration ended
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp){ ///WidgetsBinding!.instance.addPostFrameCallback((timeStamp){
                      Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(totalAmount.toDouble()); //insertin the total amount >> Go to define provider of total amount in main.dart
                    });
                  }

                  return CartItemDesign(
                    model: model,
                    context: context,
                    quanNumber: separateItemQuantityList![index],//separateItemQuantitiesList: [index],
                    );
                  },
                  childCount: snapshot.hasData ? snapshot.data!.docs.length: 0,
                ),
              );
            },
          ),
        ],
      ),
    );
  }}