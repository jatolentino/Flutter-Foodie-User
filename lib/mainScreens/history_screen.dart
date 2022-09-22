import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter/material.dart'; 
import 'package:foodie_users/assistantMethods/assistant_methods.dart'; 
import 'package:foodie_users/global/global.dart'; 
import 'package:foodie_users/widgets/order_card.dart'; 
import 'package:foodie_users/widgets/progress_bar.dart'; 
import 'package:foodie_users/widgets/simple_app_bar.dart'; 
 
class HistoryScreen extends StatefulWidget 
{ 
  @override 
  _HistoryScreenState createState() => _HistoryScreenState(); 
} 
 
class _HistoryScreenState extends State<HistoryScreen> 
{ 
  @override 
  Widget build(BuildContext context) { 
    return SafeArea( 
      child: Scaffold( 
        appBar: SimpleAppBar(title: "History",), 
        body: StreamBuilder<QuerySnapshot>( 
          stream: FirebaseFirestore.instance 
              .collection("users") 
              .doc(sharedPreferences!.getString("uid")) 
              .collection("orders") 
              .where("status", isEqualTo: "ended") 
              .orderBy("orderTime", descending: false)  ////////true index-> false index-> true again 
              .snapshots(), 
          builder: (c, snapshot) 
          { 
            return snapshot.hasData 
                ? ListView.builder( 
                    itemCount: snapshot.data!.docs.length, 
                    itemBuilder: (c, index) 
                    { 
                      return FutureBuilder<QuerySnapshot>( 
                        future: FirebaseFirestore.instance 
                            .collection("items") 
                            .where("itemID", whereIn: separateOrderItemIDs((snapshot.data!.docs[index].data()! as Map<String, dynamic>) ["productIDs"])) 
                            .where("orderBy", whereIn: (snapshot.data!.docs[index].data()! as Map<String, dynamic>)["uid"]) 
                            .orderBy("publishedDate", descending: false) 
                            .get(), 
                        builder: (c, snap) 
                        { 
                          return snap.hasData 
                              ? OrderCard( 
                            itemCount: snap.data!.docs.length, 
                            data: snap.data!.docs, 
                            orderID: snapshot.data!.docs[index].id, 
                            seperateQuantitiesList: separateOrderItemQuantities((snapshot.data!.docs[index].data()! as Map<String, dynamic>)["productIDs"]), 
                          ) 
                              : Center(child: circularProgress()); 
                        }, 
                      ); 
                    }, 
                  ) 
                : Center(child: circularProgress(),); 
          }, 
        ), 
      ), 
    ); 
  } 
}