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
    apiKey: 'AIzaSyAfdwQ_0zuQhBspWtt7KF3LXGkrhvKLoW4',
    appId: '1:153343936350:web:38ade931b4aa4e60c4b1cf',
    messagingSenderId: '153343936350',
    projectId: 'chatapp-e5947',
    authDomain: 'chatapp-e5947.firebaseapp.com',
    storageBucket: 'chatapp-e5947.appspot.com',
    measurementId: 'G-2W73Q13E4T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD3VPSV2m-QA832g63giAcxCmyBNb4fWcs',
    appId: '1:153343936350:android:ebea74f51e24e0d5c4b1cf',
    messagingSenderId: '153343936350',
    projectId: 'chatapp-e5947',
    storageBucket: 'chatapp-e5947.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBcLpkXhnbEyUlbLI9OSyPD7XjswaGAtX4',
    appId: '1:153343936350:ios:010645ebad3c5722c4b1cf',
    messagingSenderId: '153343936350',
    projectId: 'chatapp-e5947',
    storageBucket: 'chatapp-e5947.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );
}
