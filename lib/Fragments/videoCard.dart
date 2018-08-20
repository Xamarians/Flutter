import 'package:sample_list/Models/about.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoCard extends StatelessWidget {
  VideoCard(this.image);
  final Media image;

  BoxDecoration _buildShadowAndRoundedCorners() {
    return new BoxDecoration(
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

 //Show thumbnail of the video
  Widget _buildThumbnail() {
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(8.0),
      child: new Stack(
        children: <Widget>[
          new Image.asset(image.thumbnail),
          new Positioned(
            bottom: 12.0,
            right: 12.0,
            child: _buildPlayButton(),
          ),
        ],
      ),
    );
  }

 //Play button to open url of the video in web browser
  Widget _buildPlayButton() {
    return new Material(
      color: Colors.red,
      type: MaterialType.circle,
      child: new InkWell(
        onTap: () async {
          if (await canLaunch(image.url)) {
            await launch(image.url);
          }
        },
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

 //Information about video
  Widget _buildInfo() {
    return new Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 4.0, right: 4.0),
      child: new Text(
        image.title,
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
          new Flexible(flex: 3, child: _buildThumbnail()),
          new Flexible(flex: 1, child: _buildInfo()),
        ],
      ),
    );
  }
}