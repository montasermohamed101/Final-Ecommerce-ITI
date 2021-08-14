import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_final/constants/colors.dart';
import 'package:flutter_ecommerce_final/constants/my_icons.dart';
import 'package:flutter_ecommerce_final/provider/cart_provider.dart';
import 'package:flutter_ecommerce_final/provider/favs_provider.dart';
import 'package:flutter_ecommerce_final/screens/cart/cart.dart';
import 'package:flutter_ecommerce_final/screens/user_info.dart';
import 'package:flutter_ecommerce_final/screens/wishlist/wishlist.dart';
import 'package:provider/provider.dart';

class SearchByHeader extends SliverPersistentHeaderDelegate {
  final double flexibleSpace;
  final double backGroundHeight;
  final double stackPaddingTop;
  final double titlePaddingTop;
  final Widget title;
  final Widget subTitle;
  final Widget leading;
  final Widget action;
  final Widget stackChild;

  SearchByHeader({
    this.flexibleSpace = 170,
    this.backGroundHeight = 200,
    @required this.stackPaddingTop,
    this.titlePaddingTop = 35,
    @required this.title,
    this.subTitle,
    this.leading,
    this.action,
    @required this.stackChild,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var percent = shrinkOffset / (maxExtent - minExtent);
    double calculate = 1 - percent < 0 ? 0 : (1 - percent);
    return SizedBox(
      height: maxExtent,
      child: Stack(
        children: <Widget>[
          Container(
            height: minExtent + ((backGroundHeight - minExtent) * calculate),
            width: MediaQuery.of(context).size.width,

          ),
          // Positioned(
          //   top: 30,
          //   right: 10,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Consumer<FavsProvider>(
          //         builder: (_, favs, ch) => Badge(
          //           badgeColor: ColorsConsts.cartBadgeColor,
          //           position: BadgePosition.topEnd(top: 5, end: 4),
          //           badgeContent: Text(
          //             favs.getFavsItems.length.toString(),
          //             style: TextStyle(color: ColorsConsts.white),
          //           ),
          //           child: IconButton(
          //             icon: Icon(
          //                 MyAppIcons.wishlist,
          //                 color: ColorsConsts.favColor),
          //             onPressed: () {
          //               Navigator.of(context)
          //                   .pushNamed(WishlistScreen.routeName);
          //             },
          //           ),
          //         ),
          //       ),
          //       Consumer<CartProvider>(
          //         builder: (_, cart, ch) => Badge(
          //           badgeColor: ColorsConsts.cartBadgeColor,
          //           position: BadgePosition.topEnd(top: 5, end: 4),
          //           badgeContent: Text(
          //             cart.getCartItems.length.toString(),
          //             style: TextStyle(color: ColorsConsts.white),
          //           ),
          //           child: IconButton(
          //             icon: Icon(
          //               MyAppIcons.cart,
          //               color: ColorsConsts.cartColor,
          //             ),
          //             onPressed: () {
          //               Navigator.of(context).pushNamed(CartScreen.routeName);
          //             },
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Positioned(
          //   top: 32,
          //   left: 10,
          //   child: Material(
          //     borderRadius: BorderRadius.circular(10.0),
          //     color: Colors.grey.shade300,
          //     child: InkWell(
          //       borderRadius: BorderRadius.circular(10.0),
          //       splashColor: Colors.grey,
          //       onTap: () => Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => UserInfo(),
          //         ),
          //       ),
          //       child: Container(
          //         height: 40,
          //         width: 40,
          //         clipBehavior: Clip.antiAlias,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10.0),
          //             image: DecorationImage(
          //               image: NetworkImage(
          //                   'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg',
          //               ),
          //               fit: BoxFit.cover,
          //             )),
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.35,
            top: titlePaddingTop * calculate + 27,
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  leading ?? SizedBox(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Transform.scale(
                        alignment: Alignment.centerLeft,
                        scale: 1 + (calculate * .5),
                        child: Padding(
                          padding: EdgeInsets.only(top: 14 * (1 - calculate)),
                          child: title,
                        ),
                      ),
                      if (calculate > .5) ...[
                        SizedBox(height: 10),
                        Opacity(
                          opacity: calculate,
                          child: subTitle ?? SizedBox(),
                        ),
                      ]
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: EdgeInsets.only(top: 14 * calculate),
                    child: action ?? SizedBox(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: minExtent + ((stackPaddingTop - minExtent) * calculate),
            child: Opacity(
              opacity: calculate,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: stackChild,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => flexibleSpace;

  @override
  double get minExtent => kToolbarHeight + 25;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
