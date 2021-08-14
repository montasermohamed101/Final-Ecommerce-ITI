import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_final/inner_screens/categories_rail_widget.dart';
import 'package:flutter_ecommerce_final/provider/products.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'brands_rail_widget.dart';

class CategoriesFeeds extends StatefulWidget {
  CategoriesFeeds({Key key}) : super(key: key);

  static const routeName = '/categories_feeds';
  @override
  _CategoriesFeedsState createState() =>
      _CategoriesFeedsState();
}

class _CategoriesFeedsState extends State<CategoriesFeeds> {
  int _selectedIndex = 4;
  final padding = 8.0;
  String routeArgs;
  String productCategoryName;
  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context).settings.arguments.toString();
    _selectedIndex = int.parse(
      routeArgs.substring(1, 2),
    );
    print(routeArgs.toString());
    if (_selectedIndex == 0) {
      setState(() {
        productCategoryName = 'men';
      });
    }
    if (_selectedIndex == 1) {
      setState(() {
        productCategoryName = 'women';
      });
    }
    if (_selectedIndex == 2) {
      setState(() {
        productCategoryName = 'boys';
      });
    }
    if (_selectedIndex == 3) {
      setState(() {
        productCategoryName = 'girls';
      });
    }
    if (_selectedIndex == 4) {
      setState(() {
        productCategoryName = 'All';
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      minWidth: 50.0,
                      groupAlignment: 1.0,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                          if (_selectedIndex == 0) {
                            setState(() {
                              productCategoryName = 'men';
                            });
                          }
                          if (_selectedIndex == 1) {
                            setState(() {
                              productCategoryName = 'women';
                            });
                          }
                          if (_selectedIndex == 2) {
                            setState(() {
                              productCategoryName = 'boys';
                            });
                          }
                          if (_selectedIndex == 3) {
                            setState(() {
                              productCategoryName = 'girls';
                            });
                          }
                          if (_selectedIndex == 4) {
                            setState(() {
                              productCategoryName = 'All';
                            });
                          }
                          print(productCategoryName);
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      selectedLabelTextStyle: TextStyle(
                        color: Color(0xffffe6bc97),
                        fontSize: 20,
                        letterSpacing: 1,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.5,
                      ),
                      unselectedLabelTextStyle: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.8,
                      ),
                      destinations: [
                        buildRotatedTextRailDestination('men', padding),
                        buildRotatedTextRailDestination("women", padding),
                        buildRotatedTextRailDestination("boys", padding),
                        buildRotatedTextRailDestination("girls", padding),
                        buildRotatedTextRailDestination("All", padding),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // This is the main content.

          ContentSpace(context, productCategoryName)
        ],
      ),
    );
  }
}

NavigationRailDestination buildRotatedTextRailDestination(
    String text, double padding) {
  return NavigationRailDestination(
    icon: SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(text),
      ),
    ),
  );
}

class ContentSpace extends StatelessWidget {
  // final int _selectedIndex;

  final String productCategoryName;
  ContentSpace(BuildContext context, this.productCategoryName);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);
    final productsBrand = productsData.findByCategory(productCategoryName);
    if (productCategoryName == 'All') {
      for (int i = 0; i < productsData.products.length; i++) {
          productsBrand.add(productsData.products[i]);
      }
    }
    print('Category $productCategoryName');
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: productsBrand.isEmpty
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Feather.database,
                size: 80,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'No products related to this brand',
                textAlign: TextAlign.center,
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ],
          )
              : ListView.builder(
            itemCount: productsBrand.length,
            itemBuilder: (BuildContext context, int index) =>
                ChangeNotifierProvider.value(
                    value: productsBrand[index],
                    child: CategoriesRailWidget()),
          ),
        ),
      ),
    );
  }
}
