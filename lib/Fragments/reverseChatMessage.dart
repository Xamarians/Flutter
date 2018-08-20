import 'package:flutter/material.dart';

class ReverseChatMessage extends StatelessWidget {
  ReverseChatMessage({this.text, this.animationController});
  final String text;
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
        axisAlignment: 0.0,
        sizeFactor: new CurvedAnimation(
            curve: Curves.easeOut, parent: animationController),
        child: new Container(
          padding: EdgeInsets.all(10.0),
          decoration: new BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0))),
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Expanded(
                  child: new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    child: new Text(
                      text,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              )),
              new Container(
                margin: const EdgeInsets.only(left: 16.0),
                child: new CircleAvatar(
                  child: new Text(""),
                  backgroundImage: new NetworkImage(
                      'https://keka.blob.core.windows.net/a0dbae8a-c880-42dd-8947-466574e4de7d/200x200/profileimage/4477c22ea0df40c7811adca2a0ed4324.jpg?1533284927707'),
                ),
              ),
            ],
          ),
        ));
  }
}
