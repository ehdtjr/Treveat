// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB5Lkbmc0RdxxIy5nNVEzm1kUAwOh76la0',
    appId: '1:1071068114171:web:3e224706b5d4fb6a90945e',
    messagingSenderId: '1071068114171',
    projectId: 'review-b05a7',
    authDomain: 'review-b05a7.firebaseapp.com',
    storageBucket: 'review-b05a7.appspot.com',
    measurementId: 'G-ERCETBV526',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8v9FwmDLpNHpjmJ7Nz8qLb2fksqC6-Rc',
    appId: '1:1071068114171:android:b09e922806109b0790945e',
    messagingSenderId: '1071068114171',
    projectId: 'review-b05a7',
    storageBucket: 'review-b05a7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFamSTtucxgDmY0NJXdwU-2aXckZ8Db44',
    appId: '1:1071068114171:ios:a511ad5694fee43d90945e',
    messagingSenderId: '1071068114171',
    projectId: 'review-b05a7',
    storageBucket: 'review-b05a7.appspot.com',
    iosClientId: '1071068114171-avqnj75s6fvscgac76cos3449bm8cuc3.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApp',
  );
}
