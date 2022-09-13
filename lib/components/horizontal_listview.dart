import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:85.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:  <Widget>[
          Category(
            image_caption: 'Smartphones',
              image_location: 'images/icons/mobile.png'),
          Category(
              image_caption: 'Laptop',
              image_location: 'images/icons/laptop.png'),
          Category(
              image_caption: 'Smart Watch',
              image_location: 'images/icons/smart-watch.png'),
          Category(
              image_caption: 'Tablets',
              image_location: 'images/icons/ipad.png'),
          Category(
              image_caption: 'Audio',
              image_location: 'images/icons/headphones.png'),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;
  Category({
    required this.image_caption,
    required this.image_location,
});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(2.0),
    child: InkWell(onTap: (){},
    child: Container(
      width: 130.0,
      child: ListTile(
        title: Image.asset(image_location,
        width: 80.0,
        height:60.0,),
        subtitle: Container(
          alignment: Alignment.topCenter,
          child: Text(image_caption),
        ),
      ),
    ),
    ),
    );
  }
}
