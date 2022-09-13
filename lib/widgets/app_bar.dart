import 'package:flutter/material.dart';
import 'package:foodie_users/assistantMethods/cart_item_counter.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatefulWidget with PreferredSizeWidget{
  final PreferredSizeWidget? bottom;
  MyAppBar({this.bottom});

  @override
  _MyAppBarState createState() => _MyAppBarState();
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => bottom==null?Size(56, AppBar().preferredSize.height):Size(56, 80 + AppBar().preferredSize.height);

}

class _MyAppBarState extends State<MyAppBar>{
  @override
  Widget build(BuildContext context){
    return AppBar(
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
        icon: const Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pop(context);
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
    );
  }
}