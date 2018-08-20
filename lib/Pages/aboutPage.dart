import 'dart:ui' as ui;
import 'package:sample_list/Models/about.dart';
import 'package:sample_list/Animations/aboutPageAnimations.dart';
import 'package:sample_list/Fragments/videoCard.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sample_list/Fragments/imageCard.dart';
import 'package:sample_list/Models/successive.dart';

class AboutPage extends StatefulWidget {
  AboutPage({@required this.animation});

  final AnimationController animation;
  @override
  _AboutPageState createState() => _AboutPageState(controller: animation);
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  _AboutPageState({
    @required AnimationController controller,
  }) : animation = new AboutDetailsEnterAnimation(controller);

  final AboutDetailsEnterAnimation animation;
  About about = Successive.successive;
 
  //Building background and initializing animations
  Widget _buildAnimation(BuildContext context, Widget child) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Opacity(
          opacity: animation.backdropOpacity.value,
          child: new Image.asset(
            about.backdropPhoto,
            fit: BoxFit.fill,
          ),
        ),
        new BackdropFilter(
          filter: new ui.ImageFilter.blur(
            sigmaX: animation.backdropBlur.value,
            sigmaY: animation.backdropBlur.value,
          ),
          child: new Container(
            color: Colors.black.withOpacity(0.5),
            child: _buildContent(),
          ),
        ),
      ],
    );
  }

 //Build main content
  Widget _buildContent() {
    return new SingleChildScrollView(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAvatar(),
          _buildInfo(),
          _buildVideoScroller(),
        ],
      ),
    );
  }

  //Building profile picture
  Widget _buildAvatar() {
    return new Transform(
      transform: new Matrix4.diagonal3Values(
        animation.avatarSize.value,
        animation.avatarSize.value,
        1.0,
      ),
      alignment: Alignment.center,
      child: new Container(
        width: 110.0,
        height: 110.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          border: new Border.all(color: Colors.white30),
        ),
        margin: const EdgeInsets.only(top: 32.0, left: 16.0),
        padding: const EdgeInsets.all(3.0),
        child: new ClipOval(
          child: new Image.asset(about.avatar),
        ),
      ),
    );
  }

  //Information about the entity
  Widget _buildInfo() {
    return new Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            about.firstName + '\n' + about.lastName,
            style: new TextStyle(
              color: Colors.white.withOpacity(animation.nameOpacity.value),
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          new Container(
            color: Colors.white.withOpacity(0.85),
            width: animation.dividerWidth.value,
            height: 1.0,
          ),
          new Text(
            about.location,
            style: new TextStyle(
              color: Colors.white.withOpacity(animation.locationOpacity.value),
              fontWeight: FontWeight.w500,
            ),
          ),
          new Container(
            color: Colors.white.withOpacity(0.85),
            margin: const EdgeInsets.only(bottom: 16.0),
            width: animation.dividerWidth.value,
            height: 1.0,
          ),
          new Text(
            about.biography,
            style: new TextStyle(
              color: Colors.white.withOpacity(animation.biographyOpacity.value),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

 //Video carousal
  Widget _buildVideoScroller() {
    return new Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: new Transform(
        transform: new Matrix4.translationValues(
          animation.videoScrollerXTranslation.value,
          0.0,
          0.0,
        ),
        child: new Opacity(
          opacity: animation.videoScrollerOpacity.value,
          child: new SizedBox.fromSize(
            size: new Size.fromHeight(220.0),
            child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: about.medias.length,
              itemBuilder: (BuildContext context, int index) {
                if (about.medias[index].isVideo == true) {
                  var video = about.medias[index];
                  return new VideoCard(video);
                } else {
                  var image = about.medias[index];
                  return new ImageCard(image);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new AnimatedBuilder(
        animation: animation.controller,
        builder: _buildAnimation,
      ),
    );
  }
}
