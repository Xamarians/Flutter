import 'dart:async';
import 'dart:io';
import 'package:sample_list/Animations/mediaPageAnimations.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class MediaPage extends StatefulWidget {
  MediaPage({this.animation});
  final AnimationController animation;

  @override
  _MediaPageState createState() =>
      new _MediaPageState(animationController: animation);
}

class _MediaPageState extends State<MediaPage> {
  _MediaPageState({
    @required  this.animationController,
  }) : animation = new MediaPageAnimations(animationController);

  final AnimationController animationController;
  final MediaPageAnimations animation;
  bool isOpened = false;

  @override
  initState() {
    listener = () {
      setState(() {});
    };
    super.initState();
  }

  @override
  dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

//Animate the Floating action button
  animate() {
    if (!isOpened) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
    isOpened = !isOpened;
  }

//build main floating action button
  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: animation.buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.arrow_menu,
          progress: animation.animateIcon,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.elliptical(85.0, 15.0)),
        ),
      ),
    );
  }

  Future<File> _imageFile;
  bool isVideo = false;
  VideoPlayerController _controller;
  VoidCallback listener;

  void _onMediaButtonPressed(ImageSource source) {
    setState(() {
      if (_controller != null) {
        _controller.setVolume(0.0);
        _controller.removeListener(listener);
      }
      if (isVideo) {
        ImagePicker.pickVideo(source: source).then((File file) {
          if (file != null && mounted) {
            setState(() {
              _controller = VideoPlayerController.file(file)
                ..addListener(listener)
                ..setVolume(1.0)
                ..initialize()
                ..setLooping(true)
                ..play();
            });
          }
        });
      } else {
        _imageFile = ImagePicker.pickImage(source: source);
      }
    });
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.removeListener(listener);
    }
    super.deactivate();
  }

  Widget _previewVideo(VideoPlayerController controller) {
    if (controller == null) {
      return const Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    } else if (controller.value.initialized) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: AspectRatioVideo(controller),
      );
    } else {
      return const Text(
        'Error Loading Video',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _previewImage() {
    return FutureBuilder<File>(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Image.file(snapshot.data);
          } else if (snapshot.error != null) {
            return const Text(
              'Error picking image.',
              textAlign: TextAlign.center,
            );
          } else {
            return const Text(
              'You have not yet picked an image.',
              textAlign: TextAlign.center,
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isVideo ? _previewVideo(_controller) : _previewImage(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              animation.translateButton.value * 4.0,
              0.0,
            ),
            child: FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onMediaButtonPressed(ImageSource.gallery);
              },
              heroTag: 'image0',
              tooltip: 'Pick Image from gallery',
              child: const Icon(Icons.photo_library),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(85.0, 15.0)),
              ),
            ),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              animation.translateButton.value * 3.0,
              0.0,
            ),
            child: FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onMediaButtonPressed(ImageSource.camera);
              },
              heroTag: 'image1',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(85.0, 15.0)),
              ),
            ),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              animation.translateButton.value * 2.0,
              0.0,
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                isVideo = true;
                _onMediaButtonPressed(ImageSource.gallery);
              },
              heroTag: 'video0',
              tooltip: 'Pick Video from gallery',
              child: const Icon(Icons.video_library),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(85.0, 15.0)),
              ),
            ),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              animation.translateButton.value,
              0.0,
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                isVideo = true;
                _onMediaButtonPressed(ImageSource.camera);
              },
              heroTag: 'video1',
              tooltip: 'Take a Video',
              child: const Icon(Icons.videocam),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(85.0, 15.0)),
              ),
            ),
          ),
          toggle(),
        ],
      ),
    );
  }
}

class AspectRatioVideo extends StatefulWidget {
  final VideoPlayerController controller;

  AspectRatioVideo(this.controller);

  @override
  AspectRatioVideoState createState() => new AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      if (!mounted) {
        return;
      }
      if (initialized != controller.value.initialized) {
        initialized = controller.value.initialized;
        setState(() {});
      }
    };
    controller.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      final Size size = controller.value.size;
      return new Center(
        child: new AspectRatio(
          aspectRatio: size.width / size.height,
          child: new VideoPlayer(controller),
        ),
      );
    } else {
      return new Container();
    }
  }
}
