import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_final/models/product.dart';

class Products with ChangeNotifier {
  List<Product> men = [];
  List<Product> women = [];
  List<Product> boys = [];
  List<Product> girls = [];
  List<Product> products = [];
  // List<Product> get _products {
  //   return [..._products];
  //var allProducts= [men, women, boys].expand((x) => x).toList();
  // List<Product> get _products {
  //   return [..._products];
  // Future<void> fetchProducts() async {
  //   print('Fetch method is called');
  //   await FirebaseFirestore.instance
  //       .collection('products')
  //       .get()
  //       .then((QuerySnapshot productsSnapshot) {
  //     _products = [];
  //     productsSnapshot.docs.forEach((element) {
  //       // print('element.get(productBrand), ${element.get('productBrand')}');
  //       _products.insert(
  // //         0,
  //         Product(
  //             id: 'Hanes Mens ',
  //             title: 'Long Sleeve Beefy Henley Shirt',
  //             description: 'Hanes Men\'s Long Sleeve Beefy Henley Shirt ',
  //             price: 22.30,
  //             imageUrl:
  //             'https://images-na.ssl-images-amazon.com/images/I/91YHIgoKb4L._AC_UX425_.jpg',
  //             brand: 'No brand',
  //             productCategoryName: 'Clothes',
  //             quantity: 58466,
  //             isPopular: true),
  //       );
  //     });
  //   });
  // }

  // List<Product> get products {
  //   return [..._products];
  // }
  void fetchProducts() async {

    fetchProductsMen();
    fetchProductsWoman();
    fetchProductsBoys();
    fetchProductsGirls();
  }

  void fetchProductsMen() async {
    final _firestore = FirebaseFirestore.instance;
    products = [];
    await for (var snapshots in _firestore.collection('men').snapshots()) {
      for (var item in snapshots.docs)
      {
        var newProduct =
        Product(
            id:item.data()['name'],
            type: item.data()['type'],
            discount: item.data()['discount'],
            details: item.data()['details'],
            price: double.parse('${item.data()['price']}'),
            oldprice: double.parse('${item.data()['oldprice']}'),
            imageUrl:item.data()['imageUrl'],
            productCategoryName:item.data()['productCategoryName'],
            size: item.data()['size'],
            color: item.data()['color'],
            isPopular: true);
        products.add(newProduct);
      };
      print(men);
    }
  }
  void fetchProductsWoman() async {
    final _firestore = FirebaseFirestore.instance;
    products = [];
    await for (var snapshots in _firestore.collection('women').snapshots()) {
      for (var item in snapshots.docs)
      {

        var newProduct2 =
        Product(
            id:item.data()['name'],
            type: item.data()['type'],
            discount: item.data()['discount'],
            details: item.data()['details'],
            price: double.parse('${item.data()['price']}'),
            oldprice: double.parse('${item.data()['oldprice']}'),
            imageUrl:item.data()['imageUrl'],
            productCategoryName:item.data()['productCategoryName'],
            size: item.data()['size'],
            color: item.data()['color'],
            isPopular: true);
        products.add(newProduct2);
      };
      print(women);
    }
  }

  void fetchProductsBoys() async {
    final _firestore = FirebaseFirestore.instance;
    products = [];
    await for (var snapshots in _firestore.collection('boys').snapshots()) {
      for (var item in snapshots.docs)
      {
        var newProduct3 =
        Product(
            id:item.data()['name'],
            type: item.data()['type'],
            discount: item.data()['discount'],
            details: item.data()['details'],
            price: double.parse('${item.data()['price']}'),
            oldprice: double.parse('${item.data()['oldprice']}'),
            imageUrl:item.data()['imageUrl'],
            productCategoryName:item.data()['productCategoryName'],
            size: item.data()['size'],
            color: item.data()['color'],
            isPopular: true);
        products.add(newProduct3);
      };
      print(boys);
    }
  }

  void fetchProductsGirls() async {
    final _firestore = FirebaseFirestore.instance;
    products = [];
    await for (var snapshots in _firestore.collection('girls').snapshots()) {
      for (var item in snapshots.docs)
      {
        var newProduct4 =
        Product(
            id:item.data()['name'],
            type: item.data()['type'],
            discount: item.data()['discount'],
            details: item.data()['details'],
            price: double.parse('${item.data()['price']}'),
            oldprice: double.parse('${item.data()['oldprice']}'),
            imageUrl:item.data()['imageUrl'],
            productCategoryName:item.data()['productCategoryName'],
            size: item.data()['size'],
            color: item.data()['color'],
            isPopular: true);
        products.add(newProduct4);
      };
      print(girls);
    }
  }

  List<Product> get popularProducts {
    return products.where((element) => element.isPopular).toList();
  }

  Product findById(String productId) {
    return products.firstWhere((element) => element.id == productId);
  }
  List<Product> findByCategory(String categoryName) {
    List _categoryList = products
        .where((element) => element.productCategoryName
        .toLowerCase()
        .startsWith(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<Product> findByBrand(String brandName) {
    List _categoryList = products
        .where((element) =>
        element.type.toLowerCase().startsWith(brandName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<Product> searchQuery(String searchText) {
    List _searchList = products
        .where((element) =>
        element.type.toLowerCase().startsWith(searchText.toLowerCase()))
        .toList();
    return _searchList;
  }
}