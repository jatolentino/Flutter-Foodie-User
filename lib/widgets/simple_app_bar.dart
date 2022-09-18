import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget with PreferredSizeWidget{

  final PreferredSizeWidget? bottom;
  SimpleAppBar({this.bottom});

  Size get preferredSize => bottom==null?Size(56, AppBar().preferredSize.height):Size(56, 80 + AppBar().preferredSize.height); // fixes underline: class SimpleAppBar extends ... of above

  @override
  Widget build(BuildContext context){
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white,  // white
      ),
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
      centerTitle: true,
      title: const Text(
        "Foodie",
        style: TextStyle(fontSize: 45.0, letterSpacing: 3, color: Colors.white, fontFamily: "Signatra"),
      ),
    );
  }
}