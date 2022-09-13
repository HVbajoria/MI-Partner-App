import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:mi_partner_app/pages/cart_products.dart';
// my own import

import 'package:mi_partner_app/components/horizontal_listview.dart';
import 'package:mi_partner_app/components/Products.dart';
import 'package:mi_partner_app/pages/comingsoon.dart';
import 'about.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    Widget image_carousel= new Container(
      height: 150.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/accessories.jpg'),
          AssetImage('images/watch.jpeg'),
          AssetImage('images/tv.jpg'),
          AssetImage('images/watch.jpg'),
          AssetImage('images/phone.jpg'),
          AssetImage('images/laptop.jpg'),
          AssetImage('images/accessories.jpeg'),
        ],
        autoplay: true,
        animationDuration: Duration(milliseconds: 1550),
        dotSize: 4.5,
        indicatorBgPadding: 5.0,
      ),
    );
    return Scaffold(
        appBar: AppBar(
            elevation: 0.3,
            backgroundColor: Colors.deepOrangeAccent,
            title: Text('MI Partner App'),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: (){}),
              IconButton(icon: Icon(Icons.shopping_cart, color: Colors.white), onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> new Cart_products()));
              })
            ]
        ),

        drawer: Drawer(
          child: new ListView(
            children: <Widget>[
              // header of drawer
              new UserAccountsDrawerHeader(
                  accountName: Text('Harshavardhan Bajoria'),
                  accountEmail:Text('hvbajoria@gmail.com'),
                  currentAccountPicture: GestureDetector(
                    child: new CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                  decoration: new BoxDecoration(
                      color: Colors.red
                  )
              ),
              // body
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new HomePage()));
                },
                child: ListTile(
                  title: Text('Home Page'),
                  leading: Icon(Icons.home, color: Colors.blueGrey,),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new ComingSoon()));
                },
                child: ListTile(
                  title: Text('My Account'),
                  leading: Icon(Icons.person, color: Colors.blueGrey,),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new ComingSoon()));
                },
                child: ListTile(
                  title: Text('My Orders'),
                  leading: Icon(Icons.shopping_basket, color: Colors.blueGrey,),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new Cart_products()));
                },
                child: ListTile(
                  title: Text('Shopping Cart'),
                  leading: Icon(Icons.shopping_cart, color: Colors.blueGrey,),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new ComingSoon()));
                },
                child: ListTile(
                  title: Text('Favorites'),
                  leading: Icon(Icons.favorite, color: Colors.pink),
                ),
              ),

              Divider(),

              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new ComingSoon()));
                },
                child: ListTile(
                  title: Text('Settings'),
                  leading: Icon(Icons.settings, color: Colors.black,),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new About()));
                },
                child: ListTile(
                  title: Text('About'),
                  leading: Icon(Icons.help, color: Colors.blueAccent,),
                ),
              ),
            ],
          ),
        ),

        body: Column(
          children: <Widget>[
            // image carousel begins here
            image_carousel,

            // padding widget
            Padding(padding: const EdgeInsets.all(25.0),
              child: new Text('Categories', style: TextStyle(fontSize: 18.0)),),

            // Horizontal list view begins here
            HorizontalList(),

            new Padding(padding: const EdgeInsets.all(35.0),
              child: Text('Bestsellers', style: TextStyle(fontSize: 18.0)),),

            // grid view
            Flexible(
              child: Products(),
            )
          ],
        )
    );
  }
}
