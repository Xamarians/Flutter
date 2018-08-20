import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'Animations/rotatingMenuAnimations.dart';
import 'Animations/loginPageAnimations.dart';
import 'Pages/splashScreen.dart';

const API_KEY = 'AIzaSyCVLmi6iI717fJLKXt73IZO_sgbRu9d6uk-P4';
void main() {
  MapView.setApiKey(API_KEY);
  runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      //Defining theme data of the app
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),

      home: SplashScreen(),
      // Building Page Routes
      routes: <String, WidgetBuilder>{
        '/LoginPage': (BuildContext context) => new LoginAnimator(),
        '/HomePage': (BuildContext context) => new RotatingAnimator(),
      },
    ),
  );
}
