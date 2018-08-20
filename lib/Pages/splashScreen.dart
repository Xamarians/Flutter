import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> rotateLogo;

//Start timer delay
  startTime() async {
    print("Timer started");
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

//To display the page after splash animation
  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/LoginPage');
  }

  @override
  void initState() {
    super.initState();

    controller = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 50),
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();

    rotateLogo = new Tween<double>(begin: 0.0, end: 360.0)
        .animate(new CurvedAnimation(parent: controller, curve: Curves.ease));
    startTime();
    
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Stack(
      children: <Widget>[
        new Center(
          child:  new Container(
              height: 200.0,
              width: 200.0,
              child: new Transform.rotate(
                angle: rotateLogo.value,
                child: new Image.asset(
                  'assets/logo.png',
                  // height: 100.0,
                  color: Colors.cyan,
                ),
              )),
        )
      ],
    ));
  }
}
