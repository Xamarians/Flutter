import 'package:flutter/services.dart';
import 'dart:async';

class Helpers{
static const platform = const MethodChannel('samples.flutter.io/toast');

//To create Toast/alert in android/IOS
 Future<Null> getToast(String message) async {
    try {
      await platform.invokeMethod('getToast',
          <String, dynamic>{"msg": message});
    } on PlatformException catch (e) {}
  }
}
 
 