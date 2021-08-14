import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_final/constants/colors.dart';
import 'package:flutter_ecommerce_final/constants/my_icons.dart';
import 'package:flutter_ecommerce_final/models/product.dart';
import 'package:flutter_ecommerce_final/provider/cart_provider.dart';
import 'package:flutter_ecommerce_final/provider/favs_provider.dart';
import 'package:flutter_ecommerce_final/provider/products.dart';
import 'package:flutter_ecommerce_final/screens/wishlist/wishlist.dart';
import 'package:flutter_ecommerce_final/widget/feeds_products.dart';
import 'package:flutter_ecommerce_final/widget/searchby_header.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'cart/cart.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchTextController;
  final FocusNode _node = FocusNode();
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _searchTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _node.dispose();
    _searchTextController.dispose();
  }

  List<Product> _searchList = [];
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final productsList = productsData.products;
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: Colors.amber,
        title: Text('Search',
          style:TextStyle(
            fontFamily: 'Pacifico',
          ),
        ),
        actions: [
          Consumer<FavsProvider>(
            builder: (_, favs, ch) => Badge(
              badgeColor: ColorsConsts.cartBadgeColor,
              animationType: BadgeAnimationType.slide,
              toAnimate: true,
              position: BadgePosition.topEnd(top: 5, end: 4),
              badgeContent: Text(
                favs.getFavsItems.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(
                icon: Icon(
                  MyAppIcons.wishlist,
                  color: ColorsConsts.favColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(WishlistScreen.routeName);
                },
              ),
            ),
          ),
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              badgeColor: ColorsConsts.cartBadgeColor,
              animationType: BadgeAnimationType.slide,
              toAnimate: true,
              position: BadgePosition.topEnd(top: 5, end: 4),
              badgeContent: Text(
                cart.getCartItems.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(
                icon: Icon(
                  MyAppIcons.cart,
                  color: ColorsConsts.cartColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: SearchByHeader(
              stackPaddingTop: 50,
              titlePaddingTop: 20,
              // title: RichText(
              //   text: TextSpan(
              //     children: [
              //       TextSpan(
              //         text: "Search",
              //         style: TextStyle(
              //           fontFamily: 'Pacifico',
              //           fontWeight: FontWeight.bold,
              //           color: ColorsConsts.title,
              //           fontSize: 16,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              stackChild: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchTextController,
                  minLines: 1,
                  focusNode: _node,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    hintText: 'Search',
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    suffixIcon: IconButton(
                      onPressed: _searchTextController.text.isEmpty
                          ? null
                          : () {
                        _searchTextController.clear();
                        _node.unfocus();
                      },
                      icon: Icon(Feather.x,
                          color: _searchTextController.text.isNotEmpty
                              ? Colors.red
                              : Colors.grey),
                    ),
                  ),
                  onChanged: (value) {
                    _searchTextController.text.toLowerCase();
                    setState(() {
                      _searchList = productsData.searchQuery(value);
                    });
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _searchTextController.text.isNotEmpty && _searchList.isEmpty
                ? Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Icon(
                  Feather.search,
                  size: 60,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'No results found',
                  style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w700),
                ),
              ],
            )
                : GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 220 / 420,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: List.generate(
                  _searchTextController.text.isEmpty
                      ? productsList.length
                      : _searchList.length, (index) {
                return ChangeNotifierProvider.value(
                  value: _searchTextController.text.isEmpty
                      ? productsList[index]
                      : _searchList[index],
                  child: FeedProducts(),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
