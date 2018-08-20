import 'package:meta/meta.dart';

class About {
  About({
    @required this.firstName,
    @required this.lastName,
    @required this.avatar,
    @required this.backdropPhoto,
    @required this.location,
    @required this.biography,
    @required this.medias,

  });

  final String firstName;
  final String lastName;
  final String avatar;
  final String backdropPhoto;
  final String location;
  final String biography;
  final List<Media> medias;
 
}

class Media {
  Media({
    @required this.title,
    @required this.thumbnail,
    @required this.url,
    @required this.isVideo,
  });

  final String title;
  final String thumbnail;
  final String url;
  final bool isVideo;
}