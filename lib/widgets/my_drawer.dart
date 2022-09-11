import 'package:flutter/material.dart';
import 'package:foodie_users/global/global.dart';

class MyDrawer extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrsl")!
                
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height:10,),
              ]
            )
          )
        ]
      )
    )
  }
}