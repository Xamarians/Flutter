import 'package:sample_list/Models/about.dart';

class Successive {
  static final About successive = new About(
    firstName: 'Successive',
    lastName: 'Softwares',
    avatar: 'assets/avatar.png',
    backdropPhoto: 'assets/backdrop.png',
    location: 'Noida, India',
    biography:
        'We as a team in Successive software believe that focus on enhanced customer '
        'satisfaction and transparency within our team are essential to '
        'be able to succeed. We promote planning, implementing and controlling Quality'
        ' & Information Security Management System processes based on risk, including processes for software'
        'development, validation and installation, in accordance with all applicable regulations. We focus on '
        ' continual improvement towards improvising the company\'s performance baselines from time to time as well as while setting of objectives at various departments',
    medias: <Media>[
      new Media(
        title: 'Some Fun Activities At Work',
        thumbnail: 'assets/video1_thumb.png',
        url: 'https://successive.tech/wp-content/uploads/2017/06/Balloon.mp4',
        isVideo: true,
      ),
      new Media(
          title: 'Xamarians ',
          thumbnail: 'assets/xamarin.png',
          url: '',
          isVideo: false),
      new Media(
          title: 'Goa Trip',
          thumbnail: 'assets/goa.png',
          url: '',
          isVideo: false),
      new Media(
          title: 'Fun At Work',
          thumbnail: 'assets/video1_thumb.png',
          url: 'https://successive.tech/wp-content/uploads/2017/06/Balloon.mp4',
          isVideo: false),
      new Media(
          title: 'Xamarians ',
          thumbnail: 'assets/xamarin.png',
          url: '',
          isVideo: false),
      new Media(
          title: 'Goa Trip',
          thumbnail: 'assets/goa.png',
          url: '',
          isVideo: false),
    ],
  );
}
