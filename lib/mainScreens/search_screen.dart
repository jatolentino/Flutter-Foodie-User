import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter/material.dart'; 
import 'package:foodie_users/models/sellers.dart'; 
import 'package:foodie_users/widgets/sellers_design.dart'; 
 
 
class SearchScreen extends StatefulWidget 
{ 
  @override 
  _SearchScreenState createState() => _SearchScreenState(); 
} 
 
 
class _SearchScreenState extends State<SearchScreen> 
{ 
  Future<QuerySnapshot>? restaurantsDocumentsList; 
  String sellerNameText = ""; 
 
  initSearchingRestaurant(String textEntered) 
  { 
    restaurantsDocumentsList = FirebaseFirestore.instance 
        .collection("sellers") 
        .where("sellerName", isGreaterThanOrEqualTo: textEntered) 
        .get(); 
  } 
   
  @override 
  Widget build(BuildContext context) 
  { 
    return Scaffold( 
      appBar: AppBar( 
        flexibleSpace: Container( 
          decoration: BoxDecoration( 
              gradient: LinearGradient( 
                colors: [ 
                  Colors.pink.shade400, 
                  Colors.red.shade400, 
                ], 
                begin:  FractionalOffset(0.0, 0.0), 
                end:  FractionalOffset(1.0, 0.0), 
                stops: [0.0, 1.0], 
                tileMode: TileMode.clamp, 
              ) 
          ), 
        ), 
        title: TextField( 
          onChanged: (textEntered) 
          { 
            setState(() { 
              sellerNameText = textEntered; 
            }); 
            //init search 
            initSearchingRestaurant(textEntered); 
          }, 
          decoration: InputDecoration( 
            hintText: "Search Restaurant here...", 
            hintStyle: const TextStyle(color: Colors.white54), 
            border: InputBorder.none, 
            suffixIcon: IconButton( 
              icon: const Icon(Icons.search), 
              color: Colors.white, 
              onPressed: () 
              { 
                initSearchingRestaurant(sellerNameText); 
              }, 
            ), 
          ), 
          style: const TextStyle( 
            color: Colors.white, 
            fontSize: 16, 
          ), 
        ), 
      ), 
      body: FutureBuilder<QuerySnapshot>( 
        future: restaurantsDocumentsList, 
        builder: (context, snapshot) 
        { 
          return snapshot.hasData 
              ? ListView.builder( 
                  itemCount: snapshot.data!.docs.length, 
                  itemBuilder: (context, index) 
                  { 
                    Sellers model = Sellers.fromJson( 
                      snapshot.data!.docs[index].data()! as Map<String, dynamic> 
                    ); 
 
                    return SellersDesignWidget( 
                      model: model, 
                      context: context, 
                    ); 
                  }, 
                ) 
              : const Center(child: Text("No Record Found"),); 
        }, 
      ), 
    ); 
  } 
}