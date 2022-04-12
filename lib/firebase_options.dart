// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBqhql5HVct8B3-lBqzslqqQgOAgAxjCrY',
    appId: '1:388698857520:web:1837e138f6f6f239154df5',
    messagingSenderId: '388698857520',
    projectId: 'yug-nirman-vidyalaya',
    authDomain: 'yug-nirman-vidyalaya.firebaseapp.com',
    storageBucket: 'yug-nirman-vidyalaya.appspot.com',
    measurementId: 'G-99E8844SW4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7bJ194z3I-4Aq7isJ2o2ZRJHEEYMUD6s',
    appId: '1:388698857520:android:2a53b0b4323417f9154df5',
    messagingSenderId: '388698857520',
    projectId: 'yug-nirman-vidyalaya',
    storageBucket: 'yug-nirman-vidyalaya.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBreui4zdnMVjLYu_xdkdYYbto7bWAXMjw',
    appId: '1:388698857520:ios:09134c928f4a6931154df5',
    messagingSenderId: '388698857520',
    projectId: 'yug-nirman-vidyalaya',
    storageBucket: 'yug-nirman-vidyalaya.appspot.com',
    androidClientId: '388698857520-btgh8fn6cegesnnfjm8aipdb4ue0gsnl.apps.googleusercontent.com',
    iosClientId: '388698857520-2dbofp36t69o7jeu9u2v05591i850bpa.apps.googleusercontent.com',
    iosBundleId: 'com.example.yugnirmanvidyalaya',
  );
}