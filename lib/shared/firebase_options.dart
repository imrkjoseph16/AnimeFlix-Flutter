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
    apiKey: 'AIzaSyBPLZjCCAk0eEt6btAfCPmkXEUGp32X00M',
    appId: '1:289227627242:web:18dad2c63fb66466689593',
    messagingSenderId: '289227627242',
    projectId: 'animeflix-e4486',
    authDomain: 'animeflix-e4486.firebaseapp.com',
    storageBucket: 'animeflix-e4486.appspot.com',
    measurementId: 'G-9SJW3XVL84',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDdPflTY81IahyFjQz88G_U0of9RTYxnVU',
    appId: '1:289227627242:android:02d0531e1f1d74e6689593',
    messagingSenderId: '289227627242',
    projectId: 'animeflix-e4486',
    storageBucket: 'animeflix-e4486.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDi_MWj4lhMND_jYXJQMq_yp7DaKuDHJ_E',
    appId: '1:289227627242:ios:e10e0ebbf3e78936689593',
    messagingSenderId: '289227627242',
    projectId: 'animeflix-e4486',
    storageBucket: 'animeflix-e4486.appspot.com',
    androidClientId: '289227627242-4saf2bhmvldvh948gstjmk6t8knehb1i.apps.googleusercontent.com',
    iosClientId: '289227627242-qf9n9c1i5hg1uvgcklbpq705i62fimdj.apps.googleusercontent.com',
    iosBundleId: 'com.example.animeNation',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDi_MWj4lhMND_jYXJQMq_yp7DaKuDHJ_E',
    appId: '1:289227627242:ios:763019f9eae4b52e689593',
    messagingSenderId: '289227627242',
    projectId: 'animeflix-e4486',
    storageBucket: 'animeflix-e4486.appspot.com',
    androidClientId: '289227627242-4saf2bhmvldvh948gstjmk6t8knehb1i.apps.googleusercontent.com',
    iosClientId: '289227627242-mcu3hrhcj4ijhvrflus3jak179dc1d4s.apps.googleusercontent.com',
    iosBundleId: 'com.example.animeNation.RunnerTests',
  );
}
