import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_final/constants/colors.dart';
import 'package:flutter_ecommerce_final/constants/my_icons.dart';
import 'package:flutter_ecommerce_final/screens/cart/cart.dart';
import 'package:flutter_ecommerce_final/screens/feeds.dart';
import 'package:flutter_ecommerce_final/screens/wishlist/wishlist.dart';

class BackLayerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                 Colors.white,
                 Colors.amber,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        Positioned(
          top: -100.0,
          left: 140.0,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.2),
              ),
              width: 150,
              height: 250,
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          right: 100.0,
          child: Transform.rotate(
            angle: -0.8,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.2),
              ),
              width: 150,
              height: 200,
            ),
          ),
        ),
        Positioned(
          top: -50.0,
          left: 60.0,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.2),
              ),
              width: 150,
              height: 200,
            ),
          ),
        ),
        Positioned(
          bottom: 10.0,
          right: 0.0,
          child: Transform.rotate(
            angle: -0.8,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.2),
              ),
              width: 150,
              height: 200,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                content(context, () {
                  navigateTo(context, Feeds.routeName);
                }, 'Feeds', 0),
                const SizedBox(height: 10.0),
                content(context, () {
                  navigateTo(context, CartScreen.routeName);
                }, 'Cart', 1),
                const SizedBox(height: 10.0),
                content(context, () {
                  navigateTo(context, WishlistScreen.routeName);
                }, 'Wishlist', 2),
                // const SizedBox(height: 10.0),
                // content(context, () {
                //   navigateTo(context, UploadProductForm.routeName);
                // }, 'Upload a new product', 3),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List _contentIcons = [
    MyAppIcons.rss,
    MyAppIcons.bag,
    MyAppIcons.wishlist,
    //MyAppIcons.upload
  ];
  void navigateTo(BuildContext ctx, String routeName) {
    Navigator.of(ctx).pushNamed(
      routeName,
    );
  }

  Widget content(BuildContext ctx, Function fct, String text, int index) {
    return InkWell(
      onTap: fct,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Icon(_contentIcons[index])
        ],
      ),
    );
  }

}
