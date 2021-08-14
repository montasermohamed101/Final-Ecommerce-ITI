import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_final/provider/products.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'brands_rail_widget.dart';

class BrandNavigationRailScreen extends StatefulWidget {
  BrandNavigationRailScreen({Key key}) : super(key: key);

  static const routeName = '/brands_navigation_rail';
  @override
  _BrandNavigationRailScreenState createState() =>
      _BrandNavigationRailScreenState();
}

class _BrandNavigationRailScreenState extends State<BrandNavigationRailScreen> {
  int _selectedIndex = 7;
  final padding = 8.0;
  String routeArgs;
  String title;
  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context).settings.arguments.toString();
    _selectedIndex = int.parse(
      routeArgs.substring(1, 2),
    );
    print(routeArgs.toString());
    if (_selectedIndex == 0) {
      setState(() {
        title = 'Shirt';
      });
    }
    if (_selectedIndex == 1) {
      setState(() {
        title = 'Short';
      });
    }
    if (_selectedIndex == 2) {
      setState(() {
        title = 'Pants';
      });
    }
    if (_selectedIndex == 3) {
      setState(() {
        title = 'Skirt';
      });
    }
    if (_selectedIndex == 4) {
      setState(() {
        title = 'Polo';
      });
    }
    if (_selectedIndex == 5) {
      setState(() {
        title = 'Blouse';
      });
    }
    if (_selectedIndex == 6) {
      setState(() {
        title = 'Dress';
      });
    }
    if (_selectedIndex == 7) {
      setState(() {
        title = 'All';
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
                              title = 'Shirt';
                            });
                          }
                          if (_selectedIndex == 1) {
                            setState(() {
                              title = 'Short';
                            });
                          }
                          if (_selectedIndex == 2) {
                            setState(() {
                              title = 'Pants';
                            });
                          }
                          if (_selectedIndex == 3) {
                            setState(() {
                              title = 'Skirt';
                            });
                          }
                          if (_selectedIndex == 4) {
                            setState(() {
                              title = 'Polo';
                            });
                          }
                          if (_selectedIndex == 5) {
                            setState(() {
                              title = 'Blouse';
                            });
                          }

                          if (_selectedIndex == 6) {
                            setState(() {
                              title = 'Dress';
                            });
                          }
                          if (_selectedIndex == 7) {
                            setState(() {
                              title = 'All';
                            });
                          }
                          print(title);
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
                        buildRotatedTextRailDestination('Shirt', padding),
                        buildRotatedTextRailDestination("Short", padding),
                        buildRotatedTextRailDestination("Pants", padding),
                        buildRotatedTextRailDestination("Skirt", padding),
                        buildRotatedTextRailDestination("Polo", padding),
                        buildRotatedTextRailDestination("Blouse", padding),
                        buildRotatedTextRailDestination("Dress", padding),
                        buildRotatedTextRailDestination("All", padding),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // This is the main content.

          ContentSpace(context, title)
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

  final String title;
  ContentSpace(BuildContext context, this.title);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);
    final productsBrand = productsData.findByBrand(title);
    if (title == 'All') {
      for (int i = 0; i < productsData.products.length; i++) {
        productsBrand.add(productsData.products[i]);
      }
    }
    print('brand $title');
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
                          child: BrandsNavigationRail()),
                ),
        ),
      ),
    );
  }
}
