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
        return macos;
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
    apiKey: 'AIzaSyDvEDspdLqfGT3oASUC9DUR65Zkg9tyCQY',
    appId: '1:1053614187673:web:ee3e1bbc43211d1d148408',
    messagingSenderId: '1053614187673',
    projectId: 'flutter-project-real-estate',
    authDomain: 'flutter-project-real-estate.firebaseapp.com',
    storageBucket: 'flutter-project-real-estate.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRWjgsGLEm3qs5rVAjjriZEonyKf6sabg',
    appId: '1:1053614187673:android:14ca94ebb4f1415a148408',
    messagingSenderId: '1053614187673',
    projectId: 'flutter-project-real-estate',
    storageBucket: 'flutter-project-real-estate.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4Uqm8St-rs-HWPBdzWZQ3P9nmOZLPmcs',
    appId: '1:1053614187673:ios:ea87d033e0e233c7148408',
    messagingSenderId: '1053614187673',
    projectId: 'flutter-project-real-estate',
    storageBucket: 'flutter-project-real-estate.appspot.com',
    iosBundleId: 'com.example.flutterProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD4Uqm8St-rs-HWPBdzWZQ3P9nmOZLPmcs',
    appId: '1:1053614187673:ios:ef52abdf0faa92f1148408',
    messagingSenderId: '1053614187673',
    projectId: 'flutter-project-real-estate',
    storageBucket: 'flutter-project-real-estate.appspot.com',
    iosBundleId: 'com.example.flutterProject.RunnerTests',
  );
}
