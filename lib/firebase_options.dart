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
    apiKey: 'AIzaSyByb86XahlavnrN4_Q6Ojo41Po4N0Bgk4Y',
    appId: '1:305962493089:web:d58171b1e8bd56001b3ce0',
    messagingSenderId: '305962493089',
    projectId: 'nouralhj-2fb2e',
    authDomain: 'nouralhj-2fb2e.firebaseapp.com',
    storageBucket: 'nouralhj-2fb2e.appspot.com',
    measurementId: 'G-CKDLH74QVY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBYBq3z2eju9c6dSCrY7PAGzjkY5KNUcBA',
    appId: '1:305962493089:android:d3c0e80a597a26581b3ce0',
    messagingSenderId: '305962493089',
    projectId: 'nouralhj-2fb2e',
    storageBucket: 'nouralhj-2fb2e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANwcAkCKDmwh-35DcZnclKMc6UImzUC2I',
    appId: '1:305962493089:ios:abff2acf46ccf4a81b3ce0',
    messagingSenderId: '305962493089',
    projectId: 'nouralhj-2fb2e',
    storageBucket: 'nouralhj-2fb2e.appspot.com',
    iosBundleId: 'com.example.elnoorEmp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyANwcAkCKDmwh-35DcZnclKMc6UImzUC2I',
    appId: '1:305962493089:ios:abff2acf46ccf4a81b3ce0',
    messagingSenderId: '305962493089',
    projectId: 'nouralhj-2fb2e',
    storageBucket: 'nouralhj-2fb2e.appspot.com',
    iosBundleId: 'com.example.elnoorEmp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyByb86XahlavnrN4_Q6Ojo41Po4N0Bgk4Y',
    appId: '1:305962493089:web:55bac29968d106e71b3ce0',
    messagingSenderId: '305962493089',
    projectId: 'nouralhj-2fb2e',
    authDomain: 'nouralhj-2fb2e.firebaseapp.com',
    storageBucket: 'nouralhj-2fb2e.appspot.com',
    measurementId: 'G-3N1RHHG2S5',
  );
}
