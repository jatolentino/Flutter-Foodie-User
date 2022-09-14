import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodie_users/global/global.dart';
import 'package:foodie_users/authentication/auth_screen.dart';
import 'package:foodie_users/models/items.dart';
import 'package:foodie_users/models/menus.dart';
import 'package:foodie_users/widgets/app_bar.dart';
import 'package:foodie_users/widgets/items_design.dart';
// import 'package:foodie_users/uploadScreens/menus_upload_screen.dart';
import 'package:foodie_users/widgets/sellers_design.dart';
import 'package:foodie_users/widgets/my_drawer.dart';
import 'package:foodie_users/widgets/progress_bar.dart';
import 'package:foodie_users/widgets/text_widget_header.dart';

class ItemsScreen extends StatefulWidget {
  final Menus? model;
  ItemsScreen({this.model});

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      //drawer: MyDrawer(), min 4:33
      appBar: MyAppBar(sellerUID: widget.model!.sellerUID),
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
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: "Items of " + widget.model!.menuTitle.toString())),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
              .collection("sellers")
              .doc(widget.model!.sellerUID)
              .collection("menus")
              .doc(widget.model!.menuID)
              .collection("items")
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
                      Items model = Items.fromJson(
                      snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                    );
                    return ItemsDesignWidget(
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