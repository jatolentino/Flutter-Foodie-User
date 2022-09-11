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
- 