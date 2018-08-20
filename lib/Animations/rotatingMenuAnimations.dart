import 'package:flutter/material.dart';
import 'package:sample_list/Pages/rotatingMenu.dart';
import 'dart:math';


class RotatingAnimator extends StatefulWidget {
  @override
  _RotatingAnimatorState createState() => new _RotatingAnimatorState();
}

class _RotatingAnimatorState extends State<RotatingAnimator>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _heroController;

  @override
  void initState() {
    super.initState();
     _heroController = new AnimationController(
        duration: new Duration(milliseconds: 1500), vsync: this);
    _heroController.addListener(() {
      setState(() {});
    });

    _controller = new AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this)
      ..addListener(() {
        setState(() {});
      });
      
    _heroController.forward();
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
        _controller.dispose();
    _heroController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new RotatingMenu(
      animation: _controller,
      heroAnimation: _heroController,
    );
  }
}

class RotatingMenuAnimations {
  RotatingMenuAnimations(this.controller,this.heroController)
      :animationMenu =
      new Tween(begin: -pi / 2.0, end: 0.0).animate(new CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    )),

    animationMoveMenuItems = new Tween(
      begin: new Offset(0.0, 0.0),
      end: new Offset(-60.0, 0.0),
    ).animate(new CurvedAnimation(
      parent: controller,
      curve: new Interval(0.5, 1.0, curve: Curves.easeOut),
      reverseCurve: new Interval(0.0, 0.5, curve: Curves.easeIn),
    )),

    animationMoveMenuIcon = new Tween(
      begin: new Offset(5.0, 32.0),
      end: new Offset(64.0, 25.0),
    ).animate(new CurvedAnimation(
      parent: controller,
      curve: new Interval(0.5, 1.0, curve: Curves.easeOut),
      reverseCurve: new Interval(0.0, 0.5, curve: Curves.easeIn),
    )),

    animationTitleFadeInOut =
        new Tween(begin: 1.0, end: 0.0).animate(new CurvedAnimation(
      parent: controller,
      curve: new Interval(
        0.0,
        0.9,
        curve: Curves.ease,
      ),
    )),
    animationbtnZoomin = new Tween<double>(
      begin: 1000.0,
      end: 00.0,
    ).animate(new CurvedAnimation(
      parent: heroController,
      curve: Curves.ease,
    ));
     
 
 final AnimationController heroController;
 final AnimationController controller;
 final Animation<double> animationMenu;
 final Animation<double> animationTitleFadeInOut;
 final Animation<Offset> animationMoveMenuItems;
 final Animation<Offset> animationMoveMenuIcon;
 final  Animation<double> animationbtnZoomin;
}
