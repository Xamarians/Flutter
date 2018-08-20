import 'package:sample_list/Pages/mediaPage.dart';
import 'package:flutter/material.dart';

class MediaPageAnimator extends StatefulWidget {
  @override
  _MediaPageAnimatorState createState() => new _MediaPageAnimatorState();
}

class _MediaPageAnimatorState extends State<MediaPageAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350))
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MediaPage(
      animation: _controller,
    );
  }
}

class MediaPageAnimations {
  MediaPageAnimations(this.controller)
      :  animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(controller),
    buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.orange,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    )),
    translateButton = Tween<double>(
      begin: fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.0,
        0.75,
        curve: Curves.linear,
      ),
    ));
  static double fabHeight = 56.0;
  final AnimationController controller;
  final Animation<Color> buttonColor;
  final Animation<double> animateIcon;
  final Animation<double> translateButton;
}
