import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_users/global/global.dart';
import 'package:foodie_users/authentication/auth_screen.dart';
import 'package:foodie_users/widgets/sellers_design.dart';
import 'package:foodie_users/widgets/my_drawer.dart';
import 'package:foodie_users/widgets/progress_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodie_users/models/sellers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final items = [
    "slider/1.jpg",
    "slider/2.jpg",
    "slider/3.jpg",
    "slider/4.jpg",
    "slider/5.jpg",
    "slider/6.jpg",
    "slider/7.jpg",
    "slider/8.jpg",
    "slider/9.jpg",
    "slider/10.jpg",
    "slider/11.jpg",
    "slider/12.jpg",
    "slider/13.jpg",
    "slider/14.jpg",
    "slider/15.jpg",
    "slider/16.jpg",
    "slider/17.jpg",
    "slider/18.jpg",
    "slider/19.jpg",
    "slider/20.jpg",
    "slider/21.jpg",
    "slider/22.jpg",
    "slider/23.jpg",
    "slider/24.jpg",
    "slider/25.jpg",
    "slider/26.jpg",
    "slider/27.jpg",    
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
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
        title: const Text(
          "Foodie",
          style: TextStyle(fontSize: 45, fontFamily: "Signatra"),
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider( //install it, from pub.dev and put it on pubspec.yaml
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.3,
                    aspectRatio: 16/9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.decelerate,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: items.map((index) { //displaying the items of the list above
                    return Builder(builder: (BuildContext context){
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            index,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    });
                  }).toList(),
                ),
              )
            )
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
              .collection("sellers")
              .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData // adding the staggered_grid from pub_dev flutter_staggered_grid_view: NOT ^0.6.2
                ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
                : SliverStaggeredGrid.countBuilder(
                    crossAxisCount: 1, 
                    staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                    itemBuilder: (context, index)
                    {
                      Sellers sModel = Sellers.fromJson(
                        snapshot.data!.docs[index].data()! as Map<String, dynamic>
                      );
                      return SellersDesignWidget(  ///ADDEDDDD
                        model: sModel,
                        context: context,
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
            },
          ),
        ],
      ),
    );
  }
}