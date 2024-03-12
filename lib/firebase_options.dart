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
    apiKey: 'AIzaSyCIRX8mNS93IyzuEsyamB1cl3Qm1SvG9Ls',
    appId: '1:356323883967:web:3d2258282413c46c157f0a',
    messagingSenderId: '356323883967',
    projectId: 'listin-app-49d1c',
    authDomain: 'listin-app-49d1c.firebaseapp.com',
    storageBucket: 'listin-app-49d1c.appspot.com',
    measurementId: 'G-S1MY27XEXM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCpjfOwp4hZ4pFIBerS9BHfEMQOnK0z08o',
    appId: '1:356323883967:android:a7a421ada33ccc45157f0a',
    messagingSenderId: '356323883967',
    projectId: 'listin-app-49d1c',
    storageBucket: 'listin-app-49d1c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCN62ZSHRopFXh3VNdZagO8LfK5_cK9OFY',
    appId: '1:356323883967:ios:4caf0c0088f90524157f0a',
    messagingSenderId: '356323883967',
    projectId: 'listin-app-49d1c',
    storageBucket: 'listin-app-49d1c.appspot.com',
    iosBundleId: 'com.example.listinApp',
  );
}