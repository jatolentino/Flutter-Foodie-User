import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodie_users/global/global.dart';
import 'package:foodie_users/authentication/auth_screen.dart';
import 'package:foodie_users/models/menus.dart';
import 'package:foodie_users/models/sellers.dart';
import 'package:foodie_users/widgets/menus_design.dart';
// import 'package:foodie_users/uploadScreens/menus_upload_screen.dart';
import 'package:foodie_users/widgets/sellers_design.dart';
import 'package:foodie_users/widgets/my_drawer.dart';
import 'package:foodie_users/widgets/progress_bar.dart';
import 'package:foodie_users/widgets/text_widget_header.dart';

class MenusScreen extends StatefulWidget {
  
  final Sellers? model;
  MenusScreen({this.model});

  @override
  _MenusScreenState createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
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
        title: Text(
          "Foodie",
          style: const TextStyle(fontSize: 45, fontFamily: "Signatra"),
        ),
        centerTitle: true,
        //automaticallyImplyLeading: false,

        //ADD THE SHOPING CART ICON THE MENUS SCREEN HERE
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.shopping_cart),
        //     onPressed: (){
        //      // send user to cart screen
        //     },
        //   ),
        //   Positioned(
        //     child: Stack(
        //       children: const [
        //         Icon(
        //           Icons.brightness_1,
        //           size: 20.0,
        //           color: Colors.green,
        //         ),
        //         Positioned(
        //           top:3,
        //           right: 4,
        //           child: Center(
        //             child: Text("0", style: TextStyle(color: Colors.white, fontSize: 12),),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ],
      ),
      body: CustomScrollView(
        slivers: [
          // const SliverToBoxAdapter(
          //   child: ListTile(
          //     title: Text(
          //       "My Menus",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         fontFamily: "Signatra",
          //         fontSize: 30,
          //         letterSpacing: 2,
          //         color: Colors.white,
          //       )
          //     ),
          //   ),
          // ),
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: widget.model!.sellerName.toString() + " Menus")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
              .collection("sellers")
              .doc(widget.model!.sellerUID)
              .collection("menus")
              .orderBy("publishedDate", descending: true)
              .snapshots(),
            builder: (context, snapshot){
              return !snapshot.hasData
                ? SliverToBoxAdapter(
                  child: Center(child: circularProgress(),),
                  )
                : SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                  itemBuilder: (context, index){
                    Menus model = Menus.fromJson(
                      snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                    );
                    return MenusDesignWidget(
                      model: model, ////////////////////////////
                      context: context,
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                  );
            },
          )
        ]
      ),
    );
  }
}