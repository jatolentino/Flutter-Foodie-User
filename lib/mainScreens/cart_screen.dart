import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_users/assistantMethods/assistant_methods.dart';
import 'package:foodie_users/models/items.dart';
import 'package:foodie_users/widgets/app_bar.dart';
import 'package:foodie_users/widgets/cart_item_design.dart';
import 'package:foodie_users/widgets/progress_bar.dart';
import 'package:foodie_users/widgets/text_widget_header.dart';

class CartScreen extends StatefulWidget {
  
  final String? sellerUID;
  CartScreen({this.sellerUID});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int>? separateItemQuantityList;
  
  @override
  void initState() {
    super.initState();
    //separateItemQuantities();
    separateItemQuantityList = separateItemQuantities();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: MyAppBar(sellerUID: widget.sellerUID),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: 8,),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              label: const Text("Clear Cart", style: TextStyle(fontSize: 16),),
              backgroundColor: Colors.red,
              icon: const Icon(Icons.clear_all),
              heroTag: null,
              onPressed: (){

              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              label: const Text("Check Out", style: TextStyle(fontSize: 16,),),
              backgroundColor: Colors.red,
              icon: const Icon(Icons.navigate_next),
              heroTag: null,
              onPressed: (){

              },
            ),
          ),

        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true, delegate: TextWidgetHeader(title: "Total amount 120"),
          ),

          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
              .collection("items")
              .where("itemID", whereIn: separateItemIDs())
              .orderBy("publisehdDate", descending: true)
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