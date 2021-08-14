import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_ecommerce_final/constants/colors.dart';
import 'package:flutter_ecommerce_final/screens/auth/login.dart';
import 'package:flutter_ecommerce_final/services/global_method.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth/sign_up.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  List<String> images = [
    'https://images.unsplash.com/photo-1551027188-2fcf968a2cd6?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=kyler-boone-c8UArlRU9Wg-unsplash.jpg',
    'https://www.globalblue.com/business/images/article926851.ece/BINARY/TFS_Article_2019_970x643.jpg',
    'https://asffwa.com/wp-content/uploads/2019/07/the-mall-7.jpg'

  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    images.shuffle();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }



  void _loginAnonymosly() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInAnonymously();
    } catch (error) {
      _globalMethods.authErrorHandle(error.message, context);
      print('error occured ${error.message}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      CachedNetworkImage(
        imageUrl: images[0],
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: FractionalOffset(_animation.value, 0),
      ),
      Container(
        margin: EdgeInsets.only(top: 100),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: ColorsConsts.backgroundColor),
                      ),
                    )),
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Feather.user,
                          size: 18,
                        )
                      ],
                    )),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.pink.shade400),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side:
                                BorderSide(color: ColorsConsts.backgroundColor),
                          ),
                        )),
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign up',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Feather.user_plus,
                          size: 18,
                        )
                      ],
                    )),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                ),
              ),
              Text(
                'Or continue with',
                style: TextStyle(color: Colors.black),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // OutlineButton(
              //   onPressed: _googleSignIn,
              //   shape: StadiumBorder(),
              //   highlightedBorderColor: Colors.red.shade200,
              //   borderSide: BorderSide(width: 2, color: Colors.red),
              //   child: Text('Google +'),
              // ),
              _isLoading
                  ? CircularProgressIndicator()
                  : OutlinedButton(
                      onPressed: () {
                        _loginAnonymosly();
                        // Navigator.pushNamed(context, BottomBarScreen.routeName);
                      },
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.blueGrey.shade400),
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side:
                        BorderSide(color: ColorsConsts.backgroundColor),
                      ),
                    )),
                      child: Text('Sign in as a guest'),
                    ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    ]));
  }
}
