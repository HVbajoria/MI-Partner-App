import 'package:flutter/material.dart';
import 'package:mi_partner_app/main.dart';
import 'package:mi_partner_app/pages/home.dart';

import 'cart_products.dart';


class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_new_price;
  final product_detail_old_price;
  final product_detail_picture;

  ProductDetails({
    this.product_detail_name,
    this.product_detail_new_price,
    this.product_detail_old_price,
    this.product_detail_picture,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Object? prod_model="Model";
   Object? prod_color="Color";
   Object? prod_qty="Quantity";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.3,
          backgroundColor: Colors.deepOrangeAccent,
          title: InkWell(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));},
              child: Text('MI Partner App')),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: (){}),

          ]
      ),

      body: ListView(
        children:  <Widget>[
          Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color:Colors.white,
                child: Image.asset(widget.product_detail_picture),
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(widget.product_detail_name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Rs "+widget.product_detail_old_price,
                        style: TextStyle(color: Colors.black54, decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      Expanded(child: Text("Rs "+widget.product_detail_new_price, style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red,)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //    ========================== The First Button ===================
          Row(
            children: <Widget>[

              // ================== specification button ===============
              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          // Text("Model", style:TextStyle(color: Colors.black, )),
                          DropdownButton(
                              value: prod_model,
                              style: TextStyle(color:Colors.black),
                              items: <Object>['Model','Premium', 'Classic'].map<DropdownMenuItem<String>>((Object value) => DropdownMenuItem(value: value.toString(), child: Text(value.toString()))).toList(),
                              onChanged: (value){
                                setState(() {
                                  prod_model = value;
                                  value=prod_model;
                                });
                              }
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ================== Color button ===============
              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          // Text("Model", style:TextStyle(color: Colors.black, )),
                          DropdownButton(
                              value: prod_color,
                              style: TextStyle(color:Colors.black),
                              items: <Object>['Color','Black', 'Blue'].map<DropdownMenuItem<String>>((Object value) => DropdownMenuItem(value: value.toString(), child: Text(value.toString()))).toList(),
                              onChanged: (value){
                                prod_color=value;
                                value=prod_color;
                              }
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ================== Quantity  button ===============
              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          // Text("Model", style:TextStyle(color: Colors.black, )),
                          DropdownButton(
                              value: prod_qty,
                              style: const TextStyle(color:Colors.black),
                              items: <Object>['Quantity','1', '2'].map<DropdownMenuItem<String>>((Object value) => DropdownMenuItem(value: value.toString(), child: Text(value.toString()))).toList(),
                              onChanged: (value){
                                prod_qty=value;
                                value=prod_qty;
                              }
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),

          //    ========================== The Second Button ===================
          Row(
            children: <Widget>[

              // ================== specification button ===============
              Expanded(
                child: MaterialButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    // passing the values of the product to the product details page
                      builder: (context) => Cart_products(

                        product_name: widget.product_detail_name,
                        product_price:widget.product_detail_new_price,
                        product_picture: widget.product_detail_picture,
                        product_model: prod_model,
                        product_color: prod_color,
                        product_qty: prod_qty,
                      )));
                },
                  color: Colors.red,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: Text("Place Order")
                ),
              ),
              IconButton(icon: Icon(Icons.add_shopping_cart, color: Colors.red,), onPressed: (){},),
              IconButton(icon: Icon(Icons.favorite_border, color: Colors.pink), onPressed: (){},),
            ],
          ),
          Divider(color: Colors.blueGrey),
          ListTile(
            title: Text("Product Details"),
            subtitle: Text("Model Name\nSuper Start Work\nWho is it meant for?\nAs the name indicates, the RedmiBook Pro is the perfect laptop for the uncompromising working professionals, whether they have embraced the work-from-home life, or have started returning to their workplaces. It's also great for more demanding students who require to multi-task their online classes, complete assignments on Microsoft Office, or join their friends for a round of casual gaming after classes.\n \n Design\nWith a charcoal grey polycarbonate body, sleek brushed metallic finish and most importantly great balance, the RedmiBook Pro allows for an easy single-finger open allowing you to multi-task without hassles.\n\nInputs\nWith a deep 1.5 mm travel on the scissor mechanism keyboard, this laptop is a pleasure to type on with satisfying tactile feedback – You are going to enjoy writing your emails or reports on this!\nA large 100 cm squared trackpad with Windows precision driver support complements this great keyboard and allows for multi-touch gesture control for easy swipe and touch based shortcuts.\nKeeping in mind how important collaboration is for the intended audience, we’ve placed a 720p HD webcam at the top of the screen to enable seamless video calls with your colleagues, friends or family, while staying safe at home.\n\nConnectivity\nWith a wide and inclusive selection of ports on this notebook, you will have zero trouble in getting work done everyday, whether its several USB ports for accessories and external storage, HDMI 1.4 port for an external display, combo audio jack for sound, an ethernet LAN port for heavy duty data usage and more. Wi-Fi 5 and Bluetooth 5.0 ensure fast and reliable wireless connectivity while you focus on work.\n\nPerformance\nWith the latest 11th Gen Intel® Core™ i5-11300H processor, combined with 8 GB of 3200 MHz RAM and fast 512 GB NVMe SSD storage, this is a no-compromise notebook for productivity usage, whether crunching data on Excel or making reports and presentations on Word or PowerPoint. Iris Xe graphics with 80 Execution Units enables creative use cases such as image editing, video editing and also casual gaming. "),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text("Product Name", style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: Text(widget.product_detail_name),),
            ],
          ),

          Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: Text("Specifications", style: TextStyle(color: Colors.grey),),),
                  Padding(padding: EdgeInsets.all(5.0),
                  child: Text("Some details"),),
            ],
          ),

          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Suggested Products"),
          ),
          //  ================== Suggestions ==============
          Container(
            height: 390.0,
            child: Similar_products(),
          ),
        ],
      ),
    );
  }
}

class Similar_products extends StatefulWidget {
  const Similar_products({Key? key}) : super(key: key);

  @override
  _Similar_productsState createState() => _Similar_productsState();
}

class _Similar_productsState extends State<Similar_products> {
  var product_list = [
    {
      "name": "Xiaomi 12 Pro",
      "picture": "images/products/phone 1.jpg",
      "old_price": "72000",
      "price": "66999",
    },
    {
      "name": "Earbuds 3 Pro",
      "picture": "images/products/audio 2.png",
      "old_price": "5999",
      "price": "2999",
    },
    {
      "name": "Xiaomi 11i",
      "picture": "images/products/phone 2.png",
      "old_price": "31999",
      "price": "26999",
    },
    {
      "name": "Redmi Smart Band",
      "picture": "images/products/watch 1.png",
      "old_price": "5999",
      "price": "3999",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Similar_single_prod(
            prod_name: product_list[index]['name'],
            prod_picture: product_list[index]['picture'],
            prod_old_price: product_list[index]['old_price'],
            prod_price: product_list[index]['price'],
          );
        });
  }
}

class Similar_single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Similar_single_prod({
    this.prod_name,
    this.prod_old_price,
    this.prod_picture,
    this.prod_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                // passing the values of the product to the product details page
                  builder: (context) => new ProductDetails(
                    product_detail_name: prod_name,
                    product_detail_new_price: prod_price,
                    product_detail_old_price: prod_old_price,
                    product_detail_picture: prod_picture,
                  ))),
              child: GridTile(

                  footer: Container(
                      height: 95.0,
                      color: Colors.white,
                      child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(prod_name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),),
                            ),
                            Text("Rs"+ prod_price, style: TextStyle(color: Colors.red, fontSize: 14.0, fontWeight: FontWeight.w600),),
                          ]
                      )
                  ),
                  child: Image.asset(
                    prod_picture,
                    fit: BoxFit.scaleDown,
                  )),
            ),
          ),
        ));
  }
}
