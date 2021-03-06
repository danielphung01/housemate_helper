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
        return macos;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCIOLTKX7X3Mrs4qGQ_tqALHejVzU2sCCg',
    appId: '1:130234296969:web:cddca905afd4711dfbb458',
    messagingSenderId: '130234296969',
    projectId: 'housematehelper-3cd51',
    authDomain: 'housematehelper-3cd51.firebaseapp.com',
    storageBucket: 'housematehelper-3cd51.appspot.com',
    measurementId: 'G-7CPMXCLXC7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBpaZzweiMu_s-u-h46HPS4IKo7s9I4Gl4',
    appId: '1:130234296969:android:8922e7bad1d7ec91fbb458',
    messagingSenderId: '130234296969',
    projectId: 'housematehelper-3cd51',
    storageBucket: 'housematehelper-3cd51.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCRNBixguWs-HcLqd5ApCZ-wYMAJ_p6W44',
    appId: '1:130234296969:ios:3bee4cad05601f40fbb458',
    messagingSenderId: '130234296969',
    projectId: 'housematehelper-3cd51',
    storageBucket: 'housematehelper-3cd51.appspot.com',
    iosClientId: '130234296969-m0jlu84ml7amvit3k2kb2na102muuq49.apps.googleusercontent.com',
    iosBundleId: 'edu.cpp.housematehelper',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCRNBixguWs-HcLqd5ApCZ-wYMAJ_p6W44',
    appId: '1:130234296969:ios:6395139987187c52fbb458',
    messagingSenderId: '130234296969',
    projectId: 'housematehelper-3cd51',
    storageBucket: 'housematehelper-3cd51.appspot.com',
    iosClientId: '130234296969-p291pf4gnrcr32oiuig5dtcn9a7rrd80.apps.googleusercontent.com',
    iosBundleId: 'u.cpp.housematehelper',
  );
}
