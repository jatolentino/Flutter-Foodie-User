# Foodie User Mobile App for IOS and Android

This app has the following features:
- Login/Register System
- Firebase database integration
- Drawer Screen with tabs: Home, My orders, History, Search, Add New Address and Sign out
- Add menu items to cart and place an order
- Google maps integration to select a shipping address

## Result of the project
The final result of this project belongs to the ver [`ver-1.5`](https://github.com/jatolentino/Flutter-Foodie/tree/v1.5).

<!-- login drawer -->
<p align="center">
    <img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.7/sources/final_user_1.jpeg" width="600">
<br/>
<p align="center">
    <img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.2/sources/step4-test-1.png" width="150">  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    <img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.2/sources/step4-test-2.png" width="550">
    </p>

<!-- add to cart -->
<br/>
<p align="center">
    <img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.3/sources/step7-test-1.png" width="600">

<br/>
<!-- place order -->
<p align="center">
    <img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.5/sources/step9-test-1.png" width="600"> <br/>
     <img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.5/sources/step9-test-2.png" width="600">
    </p>




## How to run the project?

Clone the repository and open the terminal and navigate to the `ios` folder, then run:

    ```bash
    flutter pub add firebase_auth
    flutter pub add firebase_core
    //sudo gem install cocoapods
    flutter pub get
    pod install
    ```

- Configure the firebase database, following the link [`Step 9.1: Create a firebase project`](https://github.com/jatolentino/Flutter-Foodie#configure_firebase)

- Enjoy!


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

## 3. Show the menus in the user's screen (menus_screen.dart)
- Follow the 3 steps:
    - Create a screen to view the menus: mainScreens/menus_screen.dart (and iteratively to mainScreens/items_screen.dart & mainScreens/home_screen.dart: for showing the seller, it was already created )
    - Create a model that maps the menus: models/menus.dart (and iteratively to models/items.dart & models/sellers.dart)
    - Create a widget for the design: widgets/menus_design.dart (and iteratively to widgets/items_design.dart & widgets/seller_design.dart)
    Editing the mainScreens/menus_screen.dart and adding a text_widget_header.dart for the title
    ```dart
    import 'package:cloud_firestore/cloud_firestore.dart';
    import 'package:flutter/material.dart';
    import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
    import 'package:foodie_users/global/global.dart';
    import 'package:foodie_users/authentication/auth_screen.dart';
    import 'package:foodie_users/models/menus.dart';
    import 'package:foodie_users/models/sellers.dart';
    import 'package:foodie_users/widgets/menus_design.dart';
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
    ```
    For the text_widget_header.dart
    ```dart
    import 'package:flutter/material.dart';

    class TextWidgetHeader extends SliverPersistentHeaderDelegate{

    String? title;
    TextWidgetHeader({this.title});

    @override
    Widget build(BuildContext context, double shrinkOffset, bool overlapsContent,){
        return InkWell(
        child: Container(
            decoration: BoxDecoration(
            color: Colors.white,
            // gradient: LinearGradient(
            //   colors: [
            //     Colors.grey, //Colors.pink.shade400,
            //     Colors.white,
            //   ],
            //   begin: FractionalOffset(0.0, 0.0),
            //   end: FractionalOffset(1.0, 0.0),
            //   stops: [0.0, 1.0],
            //   tileMode: TileMode.clamp,
            // )
            ),
            height: 80.0,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: InkWell(
            child: Text(
                title!,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                fontFamily: "Signatra",
                fontSize: 30,
                letterSpacing: 2,
                color: Colors.red,
                ),
            ),
            ),
        ),
        );
    }


    @override
    // TODO: implement maxExtent
    double get maxExtent => 50;

    @override
    double get minExtent => 50;

    @override
    bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
    }
    ```

    Editing the models/menus.dart
    ```dart
    import 'package:cloud_firestore/cloud_firestore.dart';

    class Menus{
    String? menuID;
    String? sellerUID;
    String? menuTitle;
    String? menuInfo;
    Timestamp? publishedDate;
    String? thumbnailUrl;
    String? status;

    Menus({
        this.menuID,
        this.sellerUID,
        this.menuTitle,
        this.menuInfo,
        this.publishedDate,
        this.thumbnailUrl,
        this.status,
    });

    Menus.fromJson(Map<String, dynamic> json){
        menuID = json["menuID"];
        sellerUID = json["sellerUID"];
        menuTitle = json["menuTitle"];
        menuInfo = json["menuInfo"];
        publishedDate = json["publishedDate"];
        thumbnailUrl = json["thumbnailUrl"];
        status = json["status"];
    }

    Map<String, dynamic> toJson(){
        final Map<String, dynamic> data = Map<String, dynamic>();
        data["menuID"] = menuID;
        data["sellerUID"] = sellerUID;
        data["menuTitle"] = menuTitle;
        data["menuInfo"] = menuInfo;
        data["publishedDate"] = publishedDate;
        data["thumbnailUrl"] = thumbnailUrl;
        data["status"] = status;

        return data;
    }
    }
    ```

    Editing the widgets/menus_design.dart
    ```dart
    import 'package:flutter/material.dart';
    import 'package:foodie_users/mainScreens/items_screen.dart';
    import 'package:foodie_users/models/menus.dart';
    import 'package:foodie_users/models/sellers.dart';

    class MenusDesignWidget extends StatefulWidget{
    Menus? model;
    BuildContext? context;

    MenusDesignWidget({this.model, this.context});

    @override
    _MenusDesignWidgetState createState() => _MenusDesignWidgetState();
    }

    class _MenusDesignWidgetState extends State<MenusDesignWidget>{
    @override
    Widget build(BuildContext context){
        return InkWell(
        onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
        },
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
                    widget.model!.thumbnailUrl!,
                    height: 220,
                    fit: BoxFit.cover,
                ),
                const SizedBox(height: 2.0,),
                Text(
                    widget.model!.menuTitle!,
                    style: const TextStyle(
                    color: Colors.cyan,
                    fontSize: 20,
                    fontFamily: "Train",
                    )
                ),
                Text(
                    widget.model!.menuInfo!,
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

## 4. Create a item individual screen to manage the purchase

- Create the mainScreens/item_detail_screen.dart and add a basket icon that shows the quantity of purchased products (number_inc_dec: ^8.0.9, fluttertoast: ^8.0.9 {for displaying a pop-up message}, provider: ^6.0.3 dependecies to pubspec.yaml)
    ```dart
    import 'package:flutter/material.dart';
    import 'package:fluttertoast/fluttertoast.dart';
    import 'package:foodie_users/assistantMethods/assistant_methods.dart';
    import 'package:foodie_users/models/items.dart';
    import 'package:foodie_users/widgets/app_bar.dart';
    import 'package:number_inc_dec/number_inc_dec.dart';

    class ItemDetailsScreen extends StatefulWidget{
    
    final Items? model;
    ItemDetailsScreen({this.model});

    @override
    _ItemDetailsScreenState createState() => _ItemDetailsScreenState();

    }

    class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
    TextEditingController counterTextEditingController = TextEditingController();

    // addItemToCart(String foodItemId, BuildContext context, int itemCounter){

    // }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: MyAppBar(),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Image.network(widget.model!.thumbnailUrl.toString()),
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: NumberInputPrefabbed.roundedButtons( //add to yaml  number_inc_dec: ^0.8.0
                controller: counterTextEditingController,
                incDecBgColor: Colors.pink,
                min: 1,
                max: 9,
                initialValue: 1,
                buttonArrangement: ButtonArrangement.incRightDecLeft, 
                ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                widget.model!.title.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                widget.model!.longDescription.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                widget.model!.price.toString() + "\$",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
            ),

            const SizedBox(height: 60,),
            Center(
                child: InkWell(
                onTap: (){
                    int itemCounter = int.parse(counterTextEditingController.text);

                    List<String> separateItemIDsList = separateItemIDs();

                    //1. check if item already exists in cart
                    separateItemIDsList.contains(widget.model!.itemID)
                    ? Fluttertoast.showToast(msg: "Item is already in Cart.")
                    :
                    //2. then add to cart
                    addItemToCart(widget.model!.itemID, context, itemCounter);
                },
                child: Container(
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
                    ),
                    ),
                    width: MediaQuery.of(context).size.width - 150,
                    height: 50,
                    child: const Center(
                    child: Text(
                        "Add to Cart",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
                    )
                    )
                ),
                ),
            ),
            ],
        ),
        );
    }
    }
    ```
- Add an assistant method to embed two algoritms, one to add items to the shop cart (`addItemToCart()`) and the other `separateItemIDs()` to separate the uid item from its quantity (the latter because in the firestore the items cart is stored in this form 3424234223:7, being the first numberal the id and the second the quantify of products of that same item)

    ```dart
    import 'package:cloud_firestore/cloud_firestore.dart';
    import 'package:flutter/material.dart';
    import 'package:fluttertoast/fluttertoast.dart';
    import 'package:foodie_users/assistantMethods/cart_item_counter.dart';
    import 'package:foodie_users/global/global.dart';
    import 'package:provider/provider.dart';


    //don't allow repetitive addings of the same item to the database
    separateItemIDs(){
    List<String> separateItemIDsList=[], defaultItemList=[];
    int i=0;
    defaultItemList = sharedPreferences!.getStringList("userCart")!;
    for(i; i< defaultItemList.length; i++){
        String item = defaultItemList[i].toString();
        var pos = item.lastIndexOf(":");
        String getItemId = (pos != -1) ? item.substring(0, pos):item;
        print("\n This is the itemID now= " + getItemId);
        separateItemIDsList.add(getItemId); //prevent to add multiple times
    }
    print("\nThis is Items List now =");
    print(separateItemIDsList);
    return separateItemIDsList;
    }

    addItemToCart(String? foodItemId, BuildContext context, int itemCounter){
    List<String>? tempList = sharedPreferences!.getStringList("userCart");
    tempList!.add(foodItemId! + ":$itemCounter"); //this is the format of the database id: 342432323:2

    FirebaseFirestore.instance.collection("users")
        .doc(firebaseAuth.currentUser!.uid).update({
        "userCart": tempList,
        }).then((value)
        {
        // add fluttertoast dependency
        Fluttertoast.showToast(msg: "Item Added Successfully"); // pop-up message
        sharedPreferences!.setStringList("userCart", tempList);

        //update the badge
        Provider.of<CartItemCounter>(context, listen: false).displayCartListItemsNumber();
        
        });
    }
    ```
- Modify the register.dart file to add another the `cart` property to the users (also to the login.dart file, remember to delete all the users and create new ones, so they have embedded the property cart)
    ```dart
    :
    :
    Future saveDataToFirestore(User currentUser) async{
        FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
        "uid": currentUser.uid,
        "email": currentUser.email,
        "name": nameController.text.trim(),
        "photoUrl": userImageUrl,
        "status": "aproved",
        "userCart": ['garbageValue'],

        });

        //Saving the data locally on the user's phone
        SharedPreferences? sharedPreferences = await SharedPreferences.getInstance();
        //sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setString("uid", currentUser.uid);
        await sharedPreferences.setString("email", currentUser.email.toString());
        await sharedPreferences.setString("name", nameController.text.trim());
        await sharedPreferences.setString("photoUrl", userImageUrl);
        await sharedPreferences.setStringList("userCart", ['garbagevalue']);
        
    }

    @override
    Widget build(BuildContext context){
        :
        :
    ```
    In the login.dart
    ```dart
    Future readDataAndSetDataLocally(User currentUser) async{
        await FirebaseFirestore.instance.collection("users") //checking if the user that is login is the riders collection //add firebase cloud package
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
            if(snapshot.exists)
            {
            await sharedPreferences!.setString("uid", currentUser.uid);
            await sharedPreferences!.setString("email", snapshot.data()!["email"]);
            await sharedPreferences!.setString("name", snapshot.data()!["name"]);
            await sharedPreferences!.setString("photoUrl", snapshot.data()!["photoUrl"]);

            List<String> userCartList = snapshot.data()!["userCart"].cast<String>(); //Once added these new feature Cart to users, delete previous users 61-63 min 20
            await sharedPreferences!.setStringList("userCart", userCartList);
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
            // ignore: use_build_context_synchronously
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
            }
            else
            {
            firebaseAuth.signOut();
            sharedPreferences!.clear(); //added this, once you logout, sharedpreferences or cache data will be deleted
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
            showDialog(
                context: context,
                builder: (c) {
                return ErrorDialog(
                    message: "User not identified"
                );
                }
            );
            }
        });
    }
    @override
    Widget build(BuildContext context){
    :
    :
    ```

- Create an algorithm that counts items in the cart named assistandMethods/cart_Item_counter.dart
    ```dart
    import 'package:flutter/cupertino.dart';
    import 'package:foodie_users/global/global.dart';

    class CartItemCounter extends ChangeNotifier{
    int cartListItemCounter = sharedPreferences!.getStringList("userCart")!.length -1;
    int get count => cartListItemCounter;

    Future<void> displayCartListItemsNumber() async{
        cartListItemCounter = sharedPreferences!.getStringList("userCart")!.length -1;

        await Future.delayed(const Duration(milliseconds: 100), (){
        notifyListeners();
        });
    }
    }
    ```
- Create a widget the holds the number counter of the cart
    ```dart
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
    ```
    Test 4: Compiled @ the branch of [`ver-1.2`](https://github.com/jatolentino/Flutter-Foodie-User/tree/v1.2)

    <p align="center">
    <img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.2/sources/step4-test-1.png" width="150">  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    <img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.2/sources/step4-test-2.png" width="550">
    </p>

## 5. Creating a cart screen
- In mainScreens create cart_screen.dart
    ```dart
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
                heroTag: "btn1",
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
                heroTag: "btn2",
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
                .orderBy("publishedDate", descending: true)
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
      }
    }
    ```

- Modify the app_bar, so when tapping it redirects to cart_screen.dart. 

    ```dart
    import 'package:flutter/material.dart';
    import 'package:foodie_users/assistantMethods/cart_item_counter.dart';
    import 'package:foodie_users/mainScreens/cart_screen.dart';
    import 'package:provider/provider.dart';

    class MyAppBar extends StatefulWidget with PreferredSizeWidget{

    final PreferredSizeWidget? bottom;
    final String? sellerUID;

    MyAppBar({this.bottom, this.sellerUID});

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
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> CartScreen(sellerUID: widget.sellerUID)));
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
    ```

- Then, add the `sellerUID` to the item_detail_screen.dart, items_screen.dart and add the new variable (sellerUID) to app_bar.dart & cart_screen.dart

    ```dart
    :
    class _ItemsScreenState extends State<ItemsScreen> {
        @override
        Widget build(BuildContext context){
            return Scaffold(
            //drawer: MyDrawer(), min 4:33
            appBar: MyAppBar(sellerUID: widget.model!.sellerUID),
            body: CustomScrollView(
    :
    ```

## 6. Grab the number of items 
- Create a function that grabs only the quantity items from database, because the format if as ID:# (34342234:2), where the first numeral is the Item ID and the second the quantify of those items.<br/>
For instance a list of products in the cart are shown in the database as:<br/>
9722423424:2<br/>
6786745353:2<br/>
5765835343:6<br/>
3523246235:1<br/>
We want to extract the quantities in a list like: `[2, 2, 6, 1]` <br/>
In assisntantMethods/assistant_methods.dart
    
    ```dart
    separateItemQuantities(){
    List<int> separateItemQuantityList=[];
    List<String> defaultItemList=[];
    int i=1;
    defaultItemList = sharedPreferences!.getStringList("userCart")!;

    for(i; i< defaultItemList.length; i++){

        String item = defaultItemList[i].toString();

        List<String> listItemCharacters = item.split(":").toList();

        var quanNumber = int.parse(listItemCharacters[1].toString());

        print("\n This is Quantify Number= " + quanNumber.toString());
        separateItemQuantityList.add(quanNumber);
    }

    print("\nThis is Items List now =");
    print(separateItemQuantityList);
    return separateItemQuantityList;
    }
    ```

## 7. Create the widget cart design
In order to display the cart items on the cart_screen.dart, create the design widget: widgets/cart_item_design.dart

    ```dart
    import 'package:flutter/material.dart';
    import 'package:foodie_users/models/items.dart';


    class CartItemDesign extends StatefulWidget{

    final Items? model;
    BuildContext? context;
    final int? quanNumber;//final List<int>? separateItemQuantitiesList;

    CartItemDesign({
        this.model,
        this.context,
        this.quanNumber,//this.separateItemQuantitiesList,
    });

    @override
    _CartItemDesignState createState() => _CartItemDesignState();
    }

    class _CartItemDesignState extends State<CartItemDesign>{
    @override
    Widget build(BuildContext context){
        return InkWell(
        splashColor: Colors.cyan,
        child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
            height: 165,
            width: MediaQuery.of(context).size.width,
            child: Row(
                children: [
                Image.network(widget.model!.thumbnailUrl!, width: 140, height: 120,),
                const SizedBox(width: 6,),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    Text(
                        widget.model!.title!,
                        style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Kiwi",
                        ),
                    ),
                    const SizedBox(height: 1,),
                    Row( //quantity number // x 7
                        children: [
                        const Text(
                            "x",
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: "Acme",
                            ),
                        ),
                        Text(
                            widget.quanNumber.toString(),//widget.separateItemQuantitiesList.toString(), //quanNumber
                            style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: "Acme",
                            ),
                        ),
                        ],
                    ),
                    Row(
                        children: [
                        const Text(  //Price
                            "Price: ",
                            style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            ),
                        ),
                        const Text(  //MONEY
                            "\$ ",
                            style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            ),
                        ),
                        Text(
                            widget.model!.price.toString(),
                            style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            ),
                        ),
                        ],
                    ),
                    ],
                ),
                ],
            ),
            ),
        ),
        );
    }}
    ```

Test 7.1: Compiled @ the branch of [`ver-1.3`](https://github.com/jatolentino/Flutter-Foodie-User/tree/v1.3)

<p align="center">
    <img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.3/sources/step7-test-1.png" width="600">
</p>

## 8. Configure the clear cart button
- In the assistant_methods.dart, create a function called clearCartNow

```dart
    clearCartNow(context){
    sharedPreferences!.setStringList("userCart", ['garbageValue']);
    List<String>? emptyList = sharedPreferences!.getStringList("userCart");

    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .update({"userCart": emptyList}).then((value){
        sharedPreferences!.setStringList("userCart", emptyList!);
        Provider.of<CartItemCounter>(context, listen: false).displayCartListItemsNumber();
        });
    }
```

- Add the function to the button in cart_screen.dart

    ```dart
    :
    floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            const SizedBox(width: 8,),
            Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton.extended(
                label: const Text("Clear Cart", style: TextStyle(fontSize: 16),),
                backgroundColor: Colors.red,
                icon: const Icon(Icons.clear_all),
                heroTag: "btn1",
                onPressed: (){
                    clearCartNow(context);
                },
                ),
            ),
    :
    ```

- Fix the cart_screen.dart that uses the same MyAppBar widget and that causes problems when there are no items in the cart.

    ```dart
    :   
    @override
    Widget build(BuildContext context){
        return Scaffold(
        appBar: //MyAppBar(sellerUID: widget.sellerUID), this is sending to the cartsecrren (arrow_back button)
        AppBar(
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
            icon: const Icon(Icons.clear_all), //////// IT WAS Icons.arrow_back
            onPressed: (){
                clearCartNow(context);  ////// SO WHEN YOU GO BACK, THE CART IS CLEARED
                Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
                Fluttertoast.showToast(msg: "Cart has been cleared.");
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
                    //Navigator.push(context, MaterialPageRoute(builder: (c)=> CartScreen(sellerUID: widget.sellerUID)));
                    //clickeds
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
        ),
        :
    ```

- Add the clear cart function to the arrow_back button on menus_screen.dart, and then send the user to home_screen via the splash_screen

    ```dart
    leading: IconButton(
        icon: const Icon(Icons.clear_all), 
        onPressed: (){
            clearCartNow(context);
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        },
    ),
    ```
- Add the clear cart context state on the home_screen.dart
    ```dart
    :
        "slider/26.jpg",
        "slider/27.jpg",    
    ];
    @override
    void initState(){
        super.initState();
        clearCartNow(context);
    }
    Widget build(BuildContext context){
        return Scaffold(
    :
    ```

- Create an algorithm to calculate the total price of the cart in assistantMethods/total_amount.dart

    ```dart
    import 'package:flutter/cupertino.dart';

    class TotalAmount extends ChangeNotifier{
    double _totalAmount = 0;
    double get tAmount => _totalAmount;

    displayTotalAmount(double number) async {
        _totalAmount = number;
        await Future.delayed(const Duration(milliseconds: 100),()
        {
        notifyListeners();
        });
    }
    }
    ```

- Add the variables to the cart_screen and the state

    ```dart
    :
    class _CartScreenState extends State<CartScreen> {
    List<int>? separateItemQuantityList;
    num totalAmount = 0;

    @override
    void initState() {
        super.initState();
        //separateItemQuantities();

        totalAmount = 0;
        Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(0); //// ADDING THE FUNCTION from total_amount.dart
        separateItemQuantityList = separateItemQuantities();
    }
    :
    :
    Container()
        : SliverList(
        delegate: SliverChildBuilderDelegate((context, index){
            Items model = Items.fromJson(
            snapshot.data!.docs[index].data()! as Map<String, dynamic>,
            );
            
            if(index == 0){
            totalAmount = 0;
            totalAmount = totalAmount + model.price! * separateItemQuantityList![index]; //#*price
            }

            else{
            totalAmount = totalAmount + model.price! * separateItemQuantityList![index]; //#*price
            }

            if(snapshot.data!.docs.length -1 == index){ //substract the gargabe constant from database = last index/iteration ended
            WidgetsBinding.instance!.addPostFrameCallback((timeStamp){
                Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(totalAmount.toDouble()); //insertin the total amount >> Go to define provider of total amount in main.dart
            });
            }
    :
    ```

- Add the provider notifier to the main.dart

    ```dart
    :
    class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return MultiProvider(
        providers: [
            ChangeNotifierProvider(create: (c) => CartItemCounter()),
            ChangeNotifierProvider(create: (c) => TotalAmount()),  //add the widget total_amount.dart
        ],
    ```

- Adding the total Price on top of the cart_screen

    ```dart
    :
    SliverToBoxAdapter(
        child: Consumer2<TotalAmount, CartItemCounter>(builder: (context, amountProvider, cartProvider, c)
        {
        return Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
            child: cartProvider.count == 0
            ? Container ()
            : Text(
                "Total Price " + amountProvider.tAmount.toString(),
                style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                )
            )
            )
        );
        }),
    ),
    ```
    Test 8.1: Compiled @ the branch of [`ver-1.4`](https://github.com/jatolentino/Flutter-Foodie-User/tree/v1.4)

    <p align="center">
    <img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.4/sources/step8-test-1.jpeg" width="200">  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

    </p>

## 9. Creating the Check out button function 71-77
- Create the address screen on the mainScreens folder, this screen will contain the address_design widget that uses the model address.dart and the method address_changer.dart. <br/>
It's worth to mention that the address_design widget uses the Provider: changeNotifier that notifies when the first address was selected to drow a circle button and the button `Proceed` accodring to the index value of that context.
- Creating the mainScreens/address_screen.dart

    ```dart
    import 'package:cloud_firestore/cloud_firestore.dart';
    import 'package:flutter/material.dart';
    import 'package:foodie_users/assistantMethods/address_changer.dart';
    import 'package:foodie_users/global/global.dart';
    import 'package:foodie_users/mainScreens/save_address_screen.dart';
    import 'package:foodie_users/widgets/simple_app_bar.dart';
    import 'package:provider/provider.dart';
    import 'package:foodie_users/models/address.dart';
    import 'package:foodie_users/widgets/address_design.dart';
    import 'package:foodie_users/widgets/progress_bar.dart';

    class AddressScreen extends StatefulWidget {
    final double? totalAmount;
    final String? sellerUID;  //add '?' to remove error below on this.totalAmount

    AddressScreen({this.totalAmount, this.sellerUID});

    @override
    _AddressScreenState createState() => _AddressScreenState();
    }

    class _AddressScreenState extends State<AddressScreen> {
    @override
    Widget build(BuildContext context){
        return Scaffold(
        appBar: SimpleAppBar(),
        floatingActionButton: FloatingActionButton.extended(
            label: const Text("Add New Address"),
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_location, color: Colors.white,),
            onPressed: (){
            // save address to user collection
            Navigator.push(context, MaterialPageRoute(builder: (c)=> SaveAddressScreen()));
            },
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                    "Select Address:",
                    style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    ),
                ),
                ),
            ),
            
            Consumer<AddressChanger>(builder: (context, address, c){
                return Flexible(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("users")
                        .doc(sharedPreferences!.getString("uid"))
                        .collection("userAddress")
                        .snapshots(),
                    builder: (context, snapshot)
                    {
                    return !snapshot.hasData
                        ? Center(child: circularProgress(),)
                        : snapshot.data!.docs.length == 0
                        ? Container()
                        : ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index)
                                {
                                return AddressDesign(
                                    currentIndex: address.count,
                                    value: index,
                                    addressID: snapshot.data!.docs[index].id,
                                    totalAmount: widget.totalAmount,
                                    sellerUID: widget.sellerUID,
                                    model: Address.fromJson(
                                    snapshot.data!.docs[index].data()! as Map<String, dynamic>
                                    ),
                                );
                                },
                            );
                    },
                ),
                );
            }),
            

            ],
        ),
        );
    }
    }
    ```

- Creating the address.dart model
    ```dart
    class Address
    {
    String? name;
    String? phoneNumber;
    String? flatNumber;
    String? city;
    String? state;
    String? fullAddress;
    double? lat;
    double? lng;

    Address({
        this.name,
        this.phoneNumber,
        this.flatNumber,
        this.city,
        this.state,
        this.fullAddress,
        this.lat,
        this.lng,
    });

    Address.fromJson(Map<String, dynamic> json)
    {
        name = json['name'];
        phoneNumber = json['phoneNumber'];
        flatNumber = json['flatNumber'];
        city = json['city'];
        state = json['state'];
        fullAddress = json['fullAddress'];
        lat = json['lat'];
        lng = json['lng'];
    }

    Map<String, dynamic> toJson()
    {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['name'] = name;
        data['phoneNumber'] = phoneNumber;
        data['flatNumber'] = flatNumber;
        data['city'] = city;
        data['state'] = state;
        data['fullAddress'] = fullAddress;
        data['lat'] = lat;
        data['lng'] = lng;

        return data;
    }
    }
    ```
- Creating the address_desing.dart widget

    ```dart
    import 'package:flutter/material.dart';
    import 'package:foodie_users/assistantMethods/address_changer.dart';
    //import 'package:foodie_users/mainScreens/placed_order_screen.dart';
    import 'package:foodie_users/maps/maps.dart';
    import 'package:foodie_users/models/address.dart';
    import 'package:provider/provider.dart';

    class AddressDesign extends StatefulWidget
    {
    final Address? model;
    final int? currentIndex;
    final int? value;
    final String? addressID;
    final double? totalAmount;
    final String? sellerUID;

    AddressDesign({
        this.model,
        this.currentIndex,
        this.value,
        this.addressID,
        this.totalAmount,
        this.sellerUID,
    });

    @override
    _AddressDesignState createState() => _AddressDesignState();
    }



    class _AddressDesignState extends State<AddressDesign>
    {
    @override
    Widget build(BuildContext context) {
        return InkWell(
        onTap: ()
        {
            //select this address
            Provider.of<AddressChanger>(context, listen: false).displayResult(widget.value);
        },
        child: Card(
            color: Colors.grey[200],//grey.withOpacity(0.02),
            child: Column(
            children: [

                //address info
                Row(
                children: [
                    Radio(
                    groupValue: widget.currentIndex!,
                    value: widget.value!,
                    activeColor: Colors.red,
                    onChanged: (val)
                    {
                        //provider
                        Provider.of<AddressChanger>(context, listen: false).displayResult(val);
                        print(val);
                    },
                    ),
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Table(
                            children: [
                            TableRow(
                                children: [
                                const Text(
                                    "Name: ",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                Text(widget.model!.name.toString()),
                                ],
                            ),
                            TableRow(
                                children: [
                                const Text(
                                    "Phone Number: ",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                Text(widget.model!.phoneNumber.toString()),
                                ],
                            ),
                            TableRow(
                                children: [
                                const Text(
                                    "Flat Number: ",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                Text(widget.model!.flatNumber.toString()),
                                ],
                            ),
                            TableRow(
                                children: [
                                const Text(
                                    "City: ",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                Text(widget.model!.city.toString()),
                                ],
                            ),
                            TableRow(
                                children: [
                                const Text(
                                    "State: ",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                Text(widget.model!.state.toString()),
                                ],
                            ),
                            TableRow(
                                children: [
                                const Text(
                                    "Full Address: ",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                Text(widget.model!.fullAddress.toString()),
                                ],
                            ),
                            ],
                        ),
                        ),
                    ],
                    ),
                ],
                ),

                //button
                ElevatedButton(
                child: const Text("Check on Maps"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey[500],//black54,
                ),
                onPressed: ()
                {
                    MapsUtils.openMapWithPosition(widget.model!.lat!, widget.model!.lng!);
                },
                ),

                //button
                widget.value == Provider.of<AddressChanger>(context).count 
                    ? ElevatedButton(
                        child: const Text("Proceed"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.pink,
                        ),
                        onPressed: ()
                        {

                        },
                    )
                    : Container(),
            ],
            ),
        ),
        );
    }
    }
    ```
- Create the Provider: `address_changer.dart` in the assistantMehods folder that will notify to the address_design widget about the context index whe an event such a click has ocurred.
    ```dart
    import 'package:flutter/cupertino.dart';
    // GO TO MAIN AND ADD THE notifier provider
    class AddressChanger extends ChangeNotifier
    {
    int _counter = 0;
    int get count => _counter;

    displayResult(dynamic newValue)
    {
        _counter = newValue;
        notifyListeners();
    }
    }
    ```

- Add the provide to the main.dart file
```dart
:
import 'package:foodie_users/assistantMethods/address_changer.dart';
:
:
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ChangeNotifierProvider(create: (c) => TotalAmount()),
        ChangeNotifierProvider(create: (c) => AddressChanger()),//adding the address_changer.dart
      ],
:
```

- Create the save_address screen to allow users add a new address
    ```dart
    import 'package:cloud_firestore/cloud_firestore.dart';
    import 'package:flutter/material.dart';  //PAGE DISPLAYED AFTER ADD NEW ADDRESS
    import 'package:fluttertoast/fluttertoast.dart';
    import 'package:foodie_users/global/global.dart';
    import 'package:foodie_users/models/address.dart';
    import 'package:foodie_users/widgets/simple_app_bar.dart';
    import 'package:foodie_users/widgets/text_field.dart';
    import 'package:geocoding/geocoding.dart';
    import 'package:geolocator/geolocator.dart';

    class SaveAddressScreen extends StatelessWidget{
    final _name = TextEditingController();
    final _phoneNumber = TextEditingController();
    final _flatNumber = TextEditingController();
    final _city = TextEditingController();
    final _state = TextEditingController();
    final _completeAddress = TextEditingController();
    final _locationController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    List<Placemark>? placemarks;
    Position? position;

    getUserLocationAddress() async
    {
        Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
        );
        position = newPosition;
        placemarks = await placemarkFromCoordinates(
        position!.latitude, position!.longitude
        );
        Placemark pMark = placemarks![0];
        String fullAddress = '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';

        _locationController.text = fullAddress;

        _flatNumber.text = '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}';
        _city.text = '${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}';
        _state.text = '${pMark.country}';
        _completeAddress.text = fullAddress;
    }

    @override
    Widget build(BuildContext context){
        return Scaffold(
        appBar: SimpleAppBar(),
        floatingActionButton: FloatingActionButton.extended(
            label: const Text("Save Now"),
             backgroundColor: Colors.red,
            icon: const Icon(Icons.save),
            onPressed: (){
            //save address info
            if(formKey.currentState!.validate())
            {
                final model = Address(
                name: _name.text.trim(),
                state: _state.text.trim(),
                fullAddress: _completeAddress.text.trim(),
                phoneNumber: _phoneNumber.text.trim(),
                flatNumber: _flatNumber.text.trim(),
                city: _city.text.trim(),
                lat: position!.latitude,
                lng: position!.longitude,
                ).toJson();
                
                FirebaseFirestore.instance.collection("users")
                    .doc(sharedPreferences!.getString("uid"))
                    .collection("userAddress")
                    .doc(DateTime.now().millisecondsSinceEpoch.toString())
                    .set(model).then((value)
                {
                Fluttertoast.showToast(msg: "New Address has been saved.");
                formKey.currentState!.reset();
                });
            }
            },
        ),
        body:  SingleChildScrollView(
            child: Column(
            children: [
                const SizedBox(height: 6,),
                const Align(
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                    "Save New Address:",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                    ),
                    ),
                ),
                ),
                ListTile(
                leading: const Icon(
                    Icons.person_pin_circle,
                    color: Colors.black,
                    size: 35,
                ),
                title: Container(
                    width: 250,
                    child: TextField(
                    style: const TextStyle(
                        color: Colors.black,
                    ),
                    controller: _locationController,
                    decoration: const InputDecoration(
                        hintText: "What's your address?",
                        hintStyle: TextStyle(
                        color: Colors.black,
                        )
                    ),
                    ),
                ),
                ),
                const SizedBox(height: 6,),
                ElevatedButton.icon(
                label: const Text(
                    "Get my location",
                    style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(Icons.location_on, color: Colors.white,),
                style: ButtonStyle(
                    backgroundColor:  MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Colors.red),
                    ),
                    ),
                ),
                onPressed: (){
                    //get current location function
                    getUserLocationAddress();
                },
                ),
                Form(
                key: formKey,
                child: Column(
                    children: [
                    MyTextField(
                        hint: "Name",
                        controller: _name,
                    ),
                    MyTextField(
                        hint: "Phone Number",
                        controller: _phoneNumber,
                    ),
                    MyTextField(
                        hint: "City",
                        controller: _city,
                    ),
                    MyTextField(
                        hint: "State / Country",
                        controller: _state,
                    ),
                    MyTextField(
                        hint: "Address Line",
                        controller: _flatNumber,
                    ),
                    MyTextField(
                        hint: "Complete Address",
                        controller: _completeAddress,
                    ),
                    ],
                ),
                ),
            ],
            ),
        ),
        );
    }
    }
    ```

- Creating the map to allow users to Check their location on map and edit
    
    ```dart
    import 'package:url_launcher/url_launcher.dart'; //add to pubscpe url_launcher

    class MapsUtils
    {
    MapsUtils._();

    //latitude longitude
    static Future<void> openMapWithPosition(double latitude, double longitude) async
    {
        String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";


        // ignore: deprecated_member_use
        if(await canLaunch(googleMapUrl))
        {
        // ignore: deprecated_member_use
        await launch(googleMapUrl);
        }
        else
        {
        throw "Could not open the map.";
        }
    }

    //text address
    static Future<void> openMapWithAddress(String fullAddress) async
    {
        String query = Uri.encodeComponent(fullAddress);
        String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$query";

        if(await canLaunch(googleMapUrl))
        {
        await launch(googleMapUrl);
        }
        else
        {
        throw "Could not open the map.";
        }
    }
    }
    ```
    Test 9.1: Compiled @ the branch of [`ver-1.5`](https://github.com/jatolentino/Flutter-Foodie-User/tree/v1.5)

    <p align="center">
    <img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.5/sources/step9-test-1.png" width="600"> <br/>
     <img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.5/sources/step9-test-2.png" width="600">
    </p>

## 10. Create the placed order screen
- In the address_design.dart add the placed_order_screen.dart

    ```dart
    :
    onPressed: ()
        {
        Navigator.push(
            context, MaterialPageRoute(
            builder: (c)=> PlacedOrderScreen(
                addressID: widget.addressID,
                totalAmount: widget.totalAmount,
                sellerUID: widget.sellerUID,
            )
            )
        );
        },
    :
    ```

- Create the mainScreens/placed_oder_screen.dart to confim the order
    ```dart
    import 'package:cloud_firestore/cloud_firestore.dart';
    import 'package:flutter/material.dart';
    import 'package:fluttertoast/fluttertoast.dart';
    import 'package:foodie_users/assistantMethods/assistant_methods.dart';
    import 'package:foodie_users/global/global.dart';

    import 'home_screen.dart';


    class PlacedOrderScreen extends StatefulWidget
    {
    String? addressID;
    double? totalAmount;
    String? sellerUID;

    PlacedOrderScreen({this.sellerUID, this.totalAmount, this.addressID});

    @override
    _PlacedOrderScreenState createState() => _PlacedOrderScreenState();
    }



    class _PlacedOrderScreenState extends State<PlacedOrderScreen>
    {
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    addOrderDetails()
    {
        writeOrderDetailsForUser({
        "addressID": widget.addressID,
        "totalAmount": widget.totalAmount,
        "orderBy": sharedPreferences!.getString("uid"),
        "productIDs": sharedPreferences!.getStringList("userCart"),
        "paymentDetails": "Cash on Delivery",
        "orderTime": orderId,
        "isSuccess": true,
        "sellerUID": widget.sellerUID,
        "riderUID": "",
        "status": "normal",
        "orderId": orderId,
        });

        writeOrderDetailsForSeller({
        "addressID": widget.addressID,
        "totalAmount": widget.totalAmount,
        "orderBy": sharedPreferences!.getString("uid"),
        "productIDs": sharedPreferences!.getStringList("userCart"),
        "paymentDetails": "Cash on Delivery",
        "orderTime": orderId,
        "isSuccess": true,
        "sellerUID": widget.sellerUID,
        "riderUID": "",
        "status": "normal",
        "orderId": orderId,
        }).whenComplete((){
        clearCartNow(context);
        setState(() {
            orderId="";
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            Fluttertoast.showToast(msg: "Congratulations, Order has been placed successfully.");
        });
        });
    }
    
    Future writeOrderDetailsForUser(Map<String, dynamic> data) async
    {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(sharedPreferences!.getString("uid"))
            .collection("orders")
            .doc(orderId)
            .set(data);
    }

    Future writeOrderDetailsForSeller(Map<String, dynamic> data) async
    {
        await FirebaseFirestore.instance
            .collection("orders")
            .doc(orderId)
            .set(data);
    }

    @override
    Widget build(BuildContext context)
    {
        return Material(
        child: Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                Colors.pink.shade300,
                Colors.red.shade300,
                ],
                begin: const FractionalOffset(0.0, 0.5),
                end: const FractionalOffset(1.0, 0.5),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Image.asset("images/delivery.jpg"),

                const SizedBox(height: 12,),

                ElevatedButton(
                child: const Text("Place Order"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.cyan,
                ),
                onPressed: ()
                {
                    addOrderDetails();
                },
                ),

            ],
            ),
        ),
        );
    }
    }
    ```
    Test 10: Compiled @ the branch of [`ver-1.6`](https://github.com/jatolentino/Flutter-Foodie-User/tree/v1.6)

    <p align="center">
    <img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.6/sources/step10-test-1.png" width="150">;
    </p>

### 11. Create the order_card widget
- In the widgets folder create the order_card.dart file for the the design of the my_orders_screen
    
    ```dart
    import 'package:cloud_firestore/cloud_firestore.dart';
    import 'package:flutter/material.dart';
    //import 'package:foodie_users/mainScreens/order_details_screen.dart';
    import 'package:foodie_users/models/items.dart';
    import 'package:foodie_users/mainScreens/order_details_screen.dart';


    class OrderCard extends StatelessWidget
    {
    final int? itemCount;
    final List<DocumentSnapshot>? data;
    final String? orderID;
    final List<String>? seperateQuantitiesList;

    OrderCard({
        this.itemCount,
        this.data,
        this.orderID,
        this.seperateQuantitiesList,
    });

    @override
    Widget build(BuildContext context) {
        return InkWell(
        onTap: ()
        {
            Navigator.push(context, MaterialPageRoute(builder: (c)=> OrderDetailsScreen(orderID: orderID)));
        },
        child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                colors: [
                    Colors.black12,
                    Colors.white54,
                ],
                begin:  FractionalOffset(0.0, 0.0),
                end:  FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
                )
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            height: itemCount! * 125,
            child: ListView.builder(
            itemCount: itemCount,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index)
            {
                Items model = Items.fromJson(data![index].data()! as Map<String, dynamic>);
                return placedOrderDesignWidget(model, context, seperateQuantitiesList![index]);
            },
            ),
        ),
        );
    }
    }




    Widget placedOrderDesignWidget(Items model, BuildContext context, seperateQuantitiesList)
    {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
        color: Colors.grey[200],
        child: Row(
        children: [
            Image.network(model.thumbnailUrl!, width: 120,),
            const SizedBox(width: 10.0,),
            Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                const SizedBox(
                    height: 20,
                ),

                Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                    Expanded(
                        child: Text(
                        model.title!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Acme",
                        ),
                        ),
                    ),
                    const SizedBox(
                        width: 10,
                    ),
                    const Text(
                        "€ ",
                        style: TextStyle(fontSize: 16.0, color: Colors.blue),
                    ),
                    Text(
                        model.price.toString(),
                        style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 18.0,
                        ),
                    ),
                    ],
                ),

                const SizedBox(
                    height: 20,
                ),

                Row(
                    children: [
                    const Text(
                        "x ",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                        ),
                    ),
                    Expanded(
                        child: Text(
                        seperateQuantitiesList,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 30,
                            fontFamily: "Acme",
                        ),
                        ),
                    ),
                    ],
                ),

                ],
            ),
            ),
        ],
        ),
    );
    }`

    ```
- In my_drawer.dart add the MyOrdersScreen'

    ```dart
    :
    ListTile(
        leading: const Icon(Icons.reorder, color: Colors.red,),
        title: const Text(
        "My Orders",
        style: TextStyle(color: Colors.black),
        ),
        onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=> MyOrdersScreen()));
        },
    ),
    :
    ````

- Add the constructor title to the simple_app_bar.dart
    ```dart
    :

    String? title;
    final PreferredSizeWidget? bottom;
    SimpleAppBar({this.bottom, this.title});

    Size get preferredSize => bottom==null?Size(56, AppBar().preferredSize.height):Size(56, 80 + AppBar().preferredSize.height); // fixes underline: class SimpleAppBar extends ... of above

    :
    ```

- Add the title to the save_address_screen.dart

```dart
:
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: SimpleAppBar(title: "Foodie",),
      floatingActionButton: FloatingActionButton.extended(
:
```

- Create the my_orders_screen.dart

    ```dart
    import 'package:cloud_firestore/cloud_firestore.dart';
    import 'package:flutter/material.dart';
    import 'package:foodie_users/assistantMethods/assistant_methods.dart';
    import 'package:foodie_users/global/global.dart';
    import 'package:foodie_users/widgets/order_card.dart';
    import 'package:foodie_users/widgets/progress_bar.dart';
    import 'package:foodie_users/widgets/simple_app_bar.dart';

    class MyOrdersScreen extends StatefulWidget
    {
    @override
    _MyOrdersScreenState createState() => _MyOrdersScreenState();
    }

    class _MyOrdersScreenState extends State<MyOrdersScreen>
    {
    @override
    Widget build(BuildContext context) {
        return SafeArea(
        child: Scaffold(
            appBar: SimpleAppBar(title: "My Orders",),
            body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("orders")
                .where("status", isEqualTo: "normal")
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

    ```

- Create an assistant method to separe the items in the cart orders, go to assistant_methods.dart

```dart
separateOrderItemIDs(orderIDs)
{
List<String> separateItemIDsList=[], defaultItemList=[];
int i=0;

defaultItemList = List<String>.from(orderIDs);

for(i; i<defaultItemList.length; i++)
{
    //56557657:7
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");

    //56557657
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    print("\nThis is itemID now = " + getItemId);

    separateItemIDsList.add(getItemId);
}

print("\nThis is Items List now = ");
print(separateItemIDsList);

return separateItemIDsList;
}
```

- Create the order_details_screen to see the details of each orders in a separate screen

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodie_users/global/global.dart';
import 'package:foodie_users/models/address.dart';
import 'package:foodie_users/widgets/progress_bar.dart';
import 'package:foodie_users/widgets/shipment_address_design.dart';
import 'package:foodie_users/widgets/status_banner.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatefulWidget
{
  final String? orderID;

  OrderDetailsScreen({this.orderID});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen>
{
  String orderStatus = "";

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("users")
              .doc(sharedPreferences!.getString("uid"))
              .collection("orders")
              .doc(widget.orderID)
              .get(),
          builder: (c, snapshot)
          {
            Map? dataMap;
            if(snapshot.hasData)
            {
              dataMap = snapshot.data!.data()! as Map<String, dynamic>;
              orderStatus = dataMap["status"].toString();
            }
            return snapshot.hasData
                ? Container(
                    child: Column(
                      children: [
                        StatusBanner(
                          status: dataMap!["isSuccess"],
                          orderStatus: orderStatus,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "\$  " + dataMap["totalAmount"].toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Order Id = " + widget.orderID!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0), //add the time package intl
                          child: Text(
                            "Order at: " +
                                DateFormat("dd MMMM, yyyy - hh:mm aa")
                                    .format(DateTime.fromMillisecondsSinceEpoch(int.parse(dataMap["orderTime"]))),
                            style: const TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        const Divider(thickness: 4,),
                        orderStatus == "ended"
                            ? Image.asset("images/delivered.jpg")
                            : Image.asset("images/state.jpg"),
                        const Divider(thickness: 4,),
                        FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection("users")
                              .doc(sharedPreferences!.getString("uid"))
                              .collection("userAddress")
                              .doc(dataMap["addressID"])
                              .get(),
                          builder: (c, snapshot)
                          {
                            return snapshot.hasData
                                ? ShipmentAddressDesign(
                                    model: Address.fromJson(
                                      snapshot.data!.data()! as Map<String, dynamic>
                                    ),
                                  )
                                : Center(child: circularProgress(),);
                          },
                        ),
                      ],
                    ),
                  )
                : Center(child: circularProgress(),);
          },
        ),
      ),
    );
  }
}
```

- Create a status_banner widget
```dart
import 'package:flutter/material.dart';
import 'package:foodie_users/mainScreens/home_screen.dart';

class StatusBanner extends StatelessWidget
{
  final bool? status;
  final String? orderStatus;

  StatusBanner({this.status, this.orderStatus});

  @override
  Widget build(BuildContext context)
  {
    String? message;
    IconData? iconData;

    status! ? iconData = Icons.done : iconData = Icons.cancel;
    status! ? message = "Successful" : message = "Unsuccessful";

    return Container(
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
                  ),
      ),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            orderStatus == "ended"
                ? "Parcel Delivered $message"
                : "Order Placed $message",
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            width: 5,
          ),
          CircleAvatar(
            radius: 8,
            backgroundColor: Colors.grey,
            child: Center(
              child: Icon(
                iconData,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```

- Create a shipment address widget

```dart
import 'package:flutter/material.dart';
import 'package:foodie_users/mainScreens/home_screen.dart';
import 'package:foodie_users/models/address.dart';
import 'package:foodie_users/splashScreen/splash_screen.dart';

class ShipmentAddressDesign extends StatelessWidget
{
  final Address? model;

  ShipmentAddressDesign({this.model});

  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
              'Shipping Details:',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(
                children: [
                  const Text(
                    "Name",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(model!.name!),
                ],
              ),
              TableRow(
                children: [
                  const Text(
                    "Phone Number",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(model!.phoneNumber!),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model!.fullAddress!,
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MySplashScreen()));
              },
              child: Container(
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
                  ),
                ),
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: const Center(
                  child: Text(
                    "Go Back",
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

```

Test 11: Compiled @ the branch of [`ver-1.6`](https://github.com/jatolentino/Flutter-Foodie-User/tree/v1.6)

<p align="center">
<img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.6/sources/step11-test-1.png" width="600">
</p>

## 12. Final touchups

- Implementing the drawer
    - Pushing historic orders
    <p align="center">
    <img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.6/sources/step12-test-1.jpeg" width="600">
    </p>
    - Adding the search functionality of look for all the restaurants available
    <p align="center">
    <img src="https://github.com/jatolentino/Flutter-Foodie-User/blob/v1.6/sources/step12-test-1.jpeg" width="600">
    </p>
