# foodie_users

A new Flutter project.

## Follow along

### 1. Getting Started
The app has similar features up to the version of the [Repo: Flutter-Foodie-Riders](https://github.com/jatolentino/Flutter-Foodie-Riders/) @  [ver1.1](https://github.com/jatolentino/Flutter-Foodie-Rider/tree/v1.1).

### 2. Adding a drawer to show the user's profile
- Create the drawer in widgets, widgets/my_drawer.dart
    ```dart
    import 'package:flutter/material.dart';
    import 'package:foodie_users/authentication/auth_screen.dart';
    import 'package:foodie_users/global/global.dart';

    class MyDrawer extends StatelessWidget{ //important to set to true in homescreen automaticallyImplyLeading: true, OR SIMPLY DETELETE THE FALSE STATEMENT

    @override
    Widget build(BuildContext context){
        return Drawer(
        child: ListView(
            children: [ //header drawer
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
                            sharedPreferences!.getString("photoUrl")!
                    
                            ),
                        ),
                        ),
                    ),
                    ),
                    const SizedBox(height:10,),
                    Text(
                    sharedPreferences!.getString("name")!,
                    style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: "Train"),
                    ),
                ],
                ),
            ),
            const SizedBox(height: 12,),
            Container(
                padding: const EdgeInsets.only(top: 1.0),
                child: Column(
                children: [
                    // Divider(
                    //   height: 10,
                    //   color: Colors.grey,
                    //   thickness: 2,
                    // ),
                    ListTile(
                    leading: const Icon(Icons.home, color: Colors.red,),
                    title: const Text(
                        "Home",
                        style: TextStyle(color: Colors.black),
                    ),
                    onTap: (){

                    },
                    ),
                    ListTile(
                    leading: const Icon(Icons.reorder, color: Colors.red,),
                    title: const Text(
                        "My Orders",
                        style: TextStyle(color: Colors.black),
                    ),
                    onTap: (){
                        
                    },
                    ),
                    ListTile(
                    leading: const Icon(Icons.access_time, color: Colors.red,),
                    title: const Text(
                        "History",
                        style: TextStyle(color: Colors.black),
                    ),
                    onTap: (){
                        
                    },
                    ),
                    ListTile(
                    leading: const Icon(Icons.search, color: Colors.red,),
                    title: const Text(
                        "Search",
                        style: TextStyle(color: Colors.black),
                    ),
                    onTap: (){
                        
                    },
                    ),
                    ListTile(
                    leading: const Icon(Icons.add_location, color: Colors.red,),
                    title: const Text(
                        "Add New Address",
                        style: TextStyle(color: Colors.black),
                    ),
                    onTap: (){
                        
                    },
                    ),
                    ListTile(
                    leading: const Icon(Icons.exit_to_app, color: Colors.red,),
                    title: const Text(
                        "Sign Out",
                        style: TextStyle(color: Colors.black),
                    ),
                    onTap: (){
                        firebaseAuth.signOut().then((value){
                        Navigator.push(context, MaterialPageRoute(builder: (c)=> AuthScreen()));
                        });
                    },
                    ),
                ],
                )
            )
            ],
        ),
        );
    }
    }
    ```
    Test 2.1: Compiled @ the branch of [`ver-1.1`](https://github.com/jatolentino/Flutter-Foodie-User/tree/v1.1)

    <p align="center">
    <img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.1/sources/step2-test-1.jpeg" width="200">
    
    </p>
- Add image to a slider in the home_screen and append the new dependences<br/>
In pubscpec.yaml    
    ```yaml
    dependencies:
        :
        carousel_slider: ^4.1.1
        flutter_staggered_grid_view: ^0.4.1 # avoid the 6.0.2 version
    :

    assets:
        - images/
        - slider/
    ```
- Create the seller model to display sellers from Firestore<br/>
Create the lib/molds/sellers.dart file

    ```dart
    class Sellers{
        String? sellerUID;
        String? sellerName;
        String? sellerAvatarUrl;
        String? sellerEmail;

        Sellers({
            this.sellerUID,
            this.sellerName,
            this.sellerAvatarUrl,
            this.sellerEmail,
        });

        Sellers.fromJson(Map<String, dynamic> json){
            sellerUID = json["sellerUID"];
            sellerName = json["sellerName"];
            sellerAvatarUrl = json["sellerAvatarUrl"];
            sellerEmail = json["sellerEmail"];
        }

        Map<String, dynamic> toJson(){
            final Map<String, dynamic> data = new Map<String, dynamic>();
            data["sellerUID"] = sellerUID;
            data["sellerName"] = sellerName;
            data["sellerAvatarUrl"] = sellerAvatarUrl;
            data["sellerEmail"] = sellerEmail;
            return data;
        }
        }
    ```
- Create the design widget to displya the seller model (data of sellers' from Firebase) <br/>
In widgets create info_design.dart

    ```dart
    import 'package:flutter/material.dart';
    import 'package:foodie_users/models/sellers.dart';

    class InfoDesignWidget extends StatefulWidget{
    Sellers? model;
    BuildContext? context;

    InfoDesignWidget({this.model, this.context});

    @override
    _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
    }

    class _InfoDesignWidgetState extends State<InfoDesignWidget>{
    @override
    Widget build(BuildContext context){
        return InkWell(
        splashColor: Colors.amber,
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
            height: 280,
            width: MediaQuery.of(context).size.width,
            child: Column(
                children: [
                Divider(
                    height: 4,
                    thickness: 3,
                    color: Colors.grey[300],
                ),
                Image.network(
                    widget.model!.sellerAvatarUrl!,
                    height: 220,
                    fit: BoxFit.cover,
                ),
                const SizedBox(height: 2.0,),
                Text(
                    widget.model!.sellerName!,
                    style: const TextStyle(
                    color: Colors.cyan,
                    fontSize: 20,
                    fontFamily: "Train",
                    )
                ),
                Text(
                    widget.model!.sellerEmail!,
                    style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    ),
                ),
                Divider(
                    height: 4,
                    thickness: 3,
                    color: Colors.grey[300],
                ),
                ],
            )
            )
        )
        );
    }
    }
    ```

- Finally, execute the changes on home_screen.dart

    ```dart
    import 'package:carousel_slider/carousel_slider.dart';
    import 'package:cloud_firestore/cloud_firestore.dart';
    import 'package:flutter/material.dart';
    import 'package:foodie_users/global/global.dart';
    import 'package:foodie_users/authentication/auth_screen.dart';
    import 'package:foodie_users/widgets/info_design.dart';
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
            title: Text(
            "Welcome " + sharedPreferences!.getString("name")! +"!",
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
                        return InfoDesignWidget(
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
    ```
    Test 2.2: Compiled @ the branch of [`ver-1.1`](https://github.com/jatolentino/Flutter-Foodie-User/tree/v1.1)

    <p align="center">
    <img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.1/sources/step2-test-2.jpeg" width="200">  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
 
    </p>
