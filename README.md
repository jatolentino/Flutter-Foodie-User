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


