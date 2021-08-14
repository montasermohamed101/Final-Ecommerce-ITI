import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_final/inner_screens/categories_feeds.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget({Key key, this.index}) : super(key: key);
  final int index;

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<Map<String, Object>> categories = [
    {
      'categoryName': 'MEN',
      'categoryImagesPath': 'assets/images/MEN.webp',
    },
    {
      'categoryName': 'WOMEN',
      'categoryImagesPath': 'assets/images/Women.webp',
    },
    {
      'categoryName': 'BOYS',
      'categoryImagesPath': 'assets/images/Boys.webp',
    },
    {
      'categoryName': 'GIRLS',
      'categoryImagesPath': 'assets/images/Girls.webp',
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: (){
            Navigator.of(context).pushNamed(CategoriesFeeds.routeName, arguments: '${categories[widget.index]['categoryName']}');

          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(categories[widget.index]['categoryImagesPath']),
                  fit: BoxFit.cover),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 150,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Theme.of(context).backgroundColor,
            child: Text(
              categories[widget.index]['categoryName'],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
          ),
        ),

      ],
    );
  }
}
