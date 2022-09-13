import 'package:flutter/material.dart';
import 'package:mi_partner_app/pages/paymentdetails.dart';

class Cart_products extends StatefulWidget {
  var product_name;
  final product_price;
  final product_picture;
  final product_model;
  final product_color;
  final product_qty;

  Cart_products({
    this.product_name,
    this.product_price,
    this.product_picture,
    this.product_model,
    this.product_color,
    this.product_qty,
  }
  );

  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {

  var Products_on_the_cart = [{
    "name": "Xiaomi 12 Pro",
    "picture": "images/products/phone 1.jpg",
    "price": "66999",
    "model": "Premium",
    "color": "Metallic",
    "quantity": 1,
    },
    // {
    //   "name": "Earbuds 3 Pro",
    //   "picture": "images/products/audio 2.png",
    //   "price": "2,999",
    //   "model": "Classic",
    //   "color": "Blue",
    //   "quantity": 1,
    // },
  ];
  var total=0;
  var access=false;

  @override
  Widget build(BuildContext context) {

    if(widget.product_name!=null && !access) {
      Map<String, Object> m = {
        "name": widget.product_name,
        "picture": widget.product_picture,
        "price": widget.product_price,
        "model": widget.product_model,
        "color": widget.product_color,
        "quantity": widget.product_qty,
      };
      access=true;
      Products_on_the_cart.add(m);
    }

    for (var index=0;index<Products_on_the_cart.length;index++) {
      total = total +
          int.parse(Products_on_the_cart[index]["quantity"].toString()) *
              int.parse(Products_on_the_cart[index]["price"].toString());

    }

    return Scaffold(
      appBar: AppBar(
          elevation: 0.3,
          backgroundColor: Colors.deepOrangeAccent,
          title: const Text('Cart'),
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: (){}),
          ]
      ),
      body: ListView.builder(

          itemCount: Products_on_the_cart.length,
          itemBuilder: (context, index){
            return Single_cart_product(
              cart_name: Products_on_the_cart[index]["name"],
              cart_color: Products_on_the_cart[index]["color"],
              cart_model: Products_on_the_cart[index]["model"],
              cart_picture: Products_on_the_cart[index]["picture"],
              cart_price: Products_on_the_cart[index]["price"],
              cart_qty: Products_on_the_cart[index]["quantity"],
            );
          }),

      bottomNavigationBar: Container(

        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(child: ListTile(
              title: const Text("Total Amount:"),

              subtitle: Text("Rs ${total}"),
            )),

            Expanded(
              child: Material(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.redAccent.withOpacity(0.8),
                  elevation: 0.5,
                  child: MaterialButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        // passing the values of the product to the product details page
                          builder: (context) => PaymentDetails(
                            cart: Products_on_the_cart,
                          )));
                    },
                    minWidth: MediaQuery.of(context).size.width,
                    child: const Text("Check Out", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0,),
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_name;
  final cart_price;
  final cart_picture;
  final cart_model;
  final cart_color;
  final cart_qty;

  Single_cart_product({
   this.cart_name,
   this.cart_color,
   this.cart_model,
   this.cart_picture,
   this.cart_price,
   this.cart_qty
});

  @override
  Widget build(BuildContext context) {
    return Card(

      // ============= IMAGE SECTION =============
      child: ListTile(
        leading: Image.asset(cart_picture, width: 40.0, height:40.0),

        // ================ PRODUCT NAME SECTION ================
        title: Text(cart_name),

        // ================= SUB INFORMATION SECTION ===============
        subtitle: Column(
          children: <Widget>[
            Row(

              children: <Widget>[

                // ============= for model name =============
                const Padding(
                  padding: EdgeInsets.all(0.7),
                  child: Text("Model:", style: TextStyle(fontWeight: FontWeight.bold, color:Colors.black45, fontSize: 12.0)),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 8.0, 23.0, 8.0),
                  child: Text(cart_model, style: const TextStyle(color: Colors.red,fontSize: 10.0),),
                ),

                // ============= for color ============
                const Padding(
                  padding: EdgeInsets.all(0.2),
                  child: Text("Color:", style: TextStyle(fontWeight: FontWeight.bold, color:Colors.black45, fontSize: 12.0)),
                ),
                Expanded(child:
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 8.0, 23.0, 8.0),
                  child: Text(cart_color, style: const TextStyle(color: Colors.red,fontSize: 10.0)),
                )),
              ],
            ),

            // ========== PRODUCT PRICE ================
            Container(
              alignment: Alignment.topLeft,
              child: Text("Rs$cart_price", style:const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold,
              color: Colors.red,)),
            )
          ],
        ),
        trailing: Column(
          children: <Widget>[
            const Text("Qty:", style: TextStyle(fontSize: 12.0)),
            Text("$cart_qty", style: const TextStyle(fontSize: 12.0)),
          ],
        ),
      ),
    );
  }
}
