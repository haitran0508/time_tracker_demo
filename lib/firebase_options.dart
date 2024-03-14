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
    apiKey: 'AIzaSyANy2tnlkw2Tla1ftFU4GhYTcQYEAwuXiw',
    appId: '1:1069670538759:web:ac164ba73ddf3620b814a2',
    messagingSenderId: '1069670538759',
    projectId: 'time-tracker-demo-5c109',
    authDomain: 'time-tracker-demo-5c109.firebaseapp.com',
    storageBucket: 'time-tracker-demo-5c109.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0GE4KOWU41Wb6EujVJPxcF-ZMIJD5bXY',
    appId: '1:1069670538759:android:435d80fa4def6d94b814a2',
    messagingSenderId: '1069670538759',
    projectId: 'time-tracker-demo-5c109',
    storageBucket: 'time-tracker-demo-5c109.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAzDy9HU6d8Uy_5UkU-P8byBa8Vs2MabR4',
    appId: '1:1069670538759:ios:624036d37a1cb25eb814a2',
    messagingSenderId: '1069670538759',
    projectId: 'time-tracker-demo-5c109',
    storageBucket: 'time-tracker-demo-5c109.appspot.com',
    iosBundleId: 'com.example.timeTrackerDemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAzDy9HU6d8Uy_5UkU-P8byBa8Vs2MabR4',
    appId: '1:1069670538759:ios:624036d37a1cb25eb814a2',
    messagingSenderId: '1069670538759',
    projectId: 'time-tracker-demo-5c109',
    storageBucket: 'time-tracker-demo-5c109.appspot.com',
    iosBundleId: 'com.example.timeTrackerDemo',
  );
}
