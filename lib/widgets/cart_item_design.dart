import 'package:flutter/material.dart';
import 'package:foodie_users/models/items.dart';


class CartItemDesign extends StatefulWidget{

  final Items? model;
  BuildContext? context;
  final int? quanNumber;//final List<int>? separateItemQuantitiesList;

  CartItemDesign({
    this.model,
    this.context,
    this.quanNumber,//this.separateItemQuantitiesList,
  });

  @override
  _CartItemDesignState createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign>{
  @override
  Widget build(BuildContext context){
    return InkWell(
      splashColor: Colors.cyan,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          height: 140,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Image.network(widget.model!.thumbnailUrl!, width: 140, height: 120,),
              const SizedBox(width: 6,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.model!.title!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Kiwi",
                    ),
                  ),
                  const SizedBox(height: 1,),
                  Row( //quantity number // x 7
                    children: [
                      const Text(
                        "x",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: "Acme",
                        ),
                      ),
                      Text(
                        widget.quanNumber.toString(),//widget.separateItemQuantitiesList.toString(), //quanNumber
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: "Acme",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(  //Price
                        "Price: ",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      const Text(  //MONEY
                        "\$ ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        widget.model!.price.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }}