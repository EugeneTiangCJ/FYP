// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDF5_GIPT_w6l4pbU1keEZLaBoaf9wzklo',
    appId: '1:937983048424:web:6a200ee6f7c23d3c24a75d',
    messagingSenderId: '937983048424',
    projectId: 'fypapp-68dbb',
    authDomain: 'fypapp-68dbb.firebaseapp.com',
    storageBucket: 'fypapp-68dbb.appspot.com',
    measurementId: 'G-CK4Y02KZZ3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDLDNpFsmeo7613UYauLo1_XeTiUPCzw7g',
    appId: '1:937983048424:android:a112631be2162aa124a75d',
    messagingSenderId: '937983048424',
    projectId: 'fypapp-68dbb',
    storageBucket: 'fypapp-68dbb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDy_Nh-wwHOZzHMitGzQAle-qaaMTUlW7g',
    appId: '1:937983048424:ios:78b622cc9051ce5324a75d',
    messagingSenderId: '937983048424',
    projectId: 'fypapp-68dbb',
    storageBucket: 'fypapp-68dbb.appspot.com',
    androidClientId: '937983048424-hdm5m73mcai6nharvoeigqf6kets2sqv.apps.googleusercontent.com',
    iosClientId: '937983048424-immltdcfe7onkcpensb8j0b7sal1qrdm.apps.googleusercontent.com',
    iosBundleId: 'com.example.frontend',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDy_Nh-wwHOZzHMitGzQAle-qaaMTUlW7g',
    appId: '1:937983048424:ios:78b622cc9051ce5324a75d',
    messagingSenderId: '937983048424',
    projectId: 'fypapp-68dbb',
    storageBucket: 'fypapp-68dbb.appspot.com',
    androidClientId: '937983048424-hdm5m73mcai6nharvoeigqf6kets2sqv.apps.googleusercontent.com',
    iosClientId: '937983048424-immltdcfe7onkcpensb8j0b7sal1qrdm.apps.googleusercontent.com',
    iosBundleId: 'com.example.frontend',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDF5_GIPT_w6l4pbU1keEZLaBoaf9wzklo',
    appId: '1:937983048424:web:938117894f0458db24a75d',
    messagingSenderId: '937983048424',
    projectId: 'fypapp-68dbb',
    authDomain: 'fypapp-68dbb.firebaseapp.com',
    storageBucket: 'fypapp-68dbb.appspot.com',
    measurementId: 'G-FNQ4PY9VSD',
  );

}