import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodie_users/assistantMethods/assistant_methods.dart';
import 'package:foodie_users/models/items.dart';
import 'package:foodie_users/widgets/app_bar.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class ItemDetailsScreen extends StatefulWidget{
  
  final Items? model;
  ItemDetailsScreen({this.model});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();

}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  TextEditingController counterTextEditingController = TextEditingController();

  // addItemToCart(String foodItemId, BuildContext context, int itemCounter){

  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.model!.thumbnailUrl.toString()),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: NumberInputPrefabbed.roundedButtons( //add to yaml  number_inc_dec: ^0.8.0
              controller: counterTextEditingController,
              incDecBgColor: Colors.pink,
              min: 1,
              max: 9,
              initialValue: 1,
              buttonArrangement: ButtonArrangement.incRightDecLeft, 
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.title.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.longDescription.toString(),
              textAlign: TextAlign.justify,
              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.price.toString() + "\$",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),

          const SizedBox(height: 60,),
          Center(
            child: InkWell(
              onTap: (){
                int itemCounter = int.parse(counterTextEditingController.text);

                List<String> separateItemIDsList = separateItemIDs();

                //1. check if item already exists in cart
                separateItemIDsList.contains(widget.model!.itemID)
                  ? Fluttertoast.showToast(msg: "Item is already in Cart.")
                  :
                //2. then add to cart
                  addItemToCart(widget.model!.itemID, context, itemCounter);
              },
              child: Container(
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
                  ),
                ),
                width: MediaQuery.of(context).size.width - 150,
                height: 50,
                child: const Center(
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
                  )
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}