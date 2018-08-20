import 'package:sample_list/Pages/loginPage.dart';
import 'package:flutter/material.dart';

class LoginAnimator extends StatefulWidget {
  @override
  _LoginAnimatorState createState() => new _LoginAnimatorState();
}

class _LoginAnimatorState extends State<LoginAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        duration: new Duration(milliseconds: 1500), vsync: this);
    _controller.addListener(() {
      setState(() {});
      if (_controller.isCompleted) {
        //Navigating to Home Page via routing
        Navigator.pushReplacementNamed(context, "/HomePage");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new LoginPage(
      animation: _controller,
    );
  }
}

class LoginEnterAnimation {
  LoginEnterAnimation(this.controller)
      : animationBtnSqueeze = new Tween<double>(begin: 320.0, end: 70.0)
            .animate(new CurvedAnimation(
                parent: controller, curve: new Interval(0.0, 0.25))),
        animationbtnZoomout = new Tween<double>(
          begin: 70.0,
          end: 1000.0,
        ).animate(new CurvedAnimation(
          parent: controller,
          curve: new Interval(
            0.550,
            0.900,
            curve: Curves.ease,
          ),
        ));

  final AnimationController controller;

  final Animation<double> animationBtnSqueeze;
  final Animation<double> animationbtnZoomout;
}
