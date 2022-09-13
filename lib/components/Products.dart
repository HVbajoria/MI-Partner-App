import 'package:flutter/material.dart';
import 'package:mi_partner_app/pages/product_details.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name": "Xiaomi 12 Pro",
      "picture": "images/products/phone 1.jpg",
      "old_price": "72,000",
      "price": "66,999",
    },
    {
      "name": "Xiaomi Notebook",
      "picture": "images/products/laptop 1.jpg",
      "old_price": "74999",
      "price": "59999",
    },
    {
      "name": "Redmi SonicBass",
      "picture": "images/products/audio 1.png",
      "old_price": "1,599",
      "price": "1,299",
    },
    {
      "name": "Earbuds 3 Pro",
      "picture": "images/products/audio 2.png",
      "old_price": "5,999",
      "price": "2,999",
    },
    {
      "name": "Notebook Pro 120G",
      "picture": "images/products/laptop 2.jpg",
      "old_price": "69,999",
      "price": "69,999",
    },
    {
      "name": "Xiaomi 11i",
      "picture": "images/products/phone 2.png",
      "old_price": "31,999",
      "price": "26,999",
    },
    {
      "name": "Mi Tv 5A",
      "picture": "images/products/tv 1.jpg",
      "old_price": "24,999",
      "price": "14,999",
    },
    {
      "name": "Redmi Smart Band",
      "picture": "images/products/watch 1.png",
      "old_price": "5,999",
      "price": "3,999",
    },
    {
      "name": "Xiaomi Pad 5",
      "picture": "images/products/tablet 1.jpg",
      "old_price": "37,999",
      "price": "26,999",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Single_prod(
              prod_name: product_list[index]['name'],
              prod_picture: product_list[index]['picture'],
              prod_old_price: product_list[index]['old_price'],
              prod_price: product_list[index]['price'],
            ),
          );
        });
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Single_prod({
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
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
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
                child: Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(prod_name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),),
                      ),
                      Text("Rs"+ prod_price, style: TextStyle(color: Colors.red, fontSize: 14.0, fontWeight: FontWeight.w600),),
                    ]
                  )
                ),
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
