import 'package:flutter/material.dart';

class Product with ChangeNotifier{
  final String id;
  final int discount;
  final String type;
  final List<dynamic> details;
  final double price;
  final double oldprice;
  final String imageUrl;
  final String productCategoryName;
  final List size;
  final List color;
  final bool isFavorite;
  final bool isPopular;


  Product({this.id,this.discount,this.type,this.details,this.price,this.oldprice,this.color, this.imageUrl, this.productCategoryName,this.size, this.isFavorite, this.isPopular});
}
