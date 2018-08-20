import 'package:sample_list/Models/about.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  ImageCard(this.video);
  final Media video;

  //Building Imagecard Border and shadow
  BoxDecoration _buildShadowAndRoundedCorners() {
    return new BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.white.withOpacity(0.4),
      borderRadius: new BorderRadius.circular(10.0),
      boxShadow: <BoxShadow>[
        new BoxShadow(
          spreadRadius: 2.0,
          blurRadius: 10.0,
          color: Colors.black26,
        ),
      ],
    );
  }

 //Image Inside the container
  Widget _buildThumbnail(BuildContext context) {
    return new ClipRRect(
        borderRadius: new BorderRadius.circular(25.0),
        child: new MaterialButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return new Center(
                  child: new Image.asset(
                    video.thumbnail,
                    fit: BoxFit.scaleDown,
                  ),
                );
              },
            );
          },
          child: new Image.asset(
            video.thumbnail,
            fit: BoxFit.contain,
          ),
        ));
  }
 // Information 
  Widget _buildInfo() {
    return new Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 4.0, right: 4.0),
      child: new Text(
        video.title,
        style: new TextStyle(color: Colors.white.withOpacity(0.85)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 175.0,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      decoration: _buildShadowAndRoundedCorners(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(child: _buildThumbnail(context)),
          new Container(child: _buildInfo()),
        ],
      ),
    );
  }
}
