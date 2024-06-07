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
    apiKey: 'AIzaSyBoL1VURp74LnTpPNbIy6gaAuSCO9pWVn0',
    appId: '1:952072927002:web:61165dc06504cec4d45ea3',
    messagingSenderId: '952072927002',
    projectId: 'game-questions-build-with-ai',
    authDomain: 'game-questions-build-with-ai.firebaseapp.com',
    storageBucket: 'game-questions-build-with-ai.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBYGR-25LTbCs8naoR0hOlS-bkWjymC0oQ',
    appId: '1:952072927002:android:8d953af1dc483c22d45ea3',
    messagingSenderId: '952072927002',
    projectId: 'game-questions-build-with-ai',
    storageBucket: 'game-questions-build-with-ai.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBxRIoVLdE7rhqCmGTSnjHDXpenoPcTaZA',
    appId: '1:952072927002:ios:77e9e3412fbd5502d45ea3',
    messagingSenderId: '952072927002',
    projectId: 'game-questions-build-with-ai',
    storageBucket: 'game-questions-build-with-ai.appspot.com',
    iosBundleId: 'com.mahmoudalaa.buildWithAiWorkshop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBxRIoVLdE7rhqCmGTSnjHDXpenoPcTaZA',
    appId: '1:952072927002:ios:77e9e3412fbd5502d45ea3',
    messagingSenderId: '952072927002',
    projectId: 'game-questions-build-with-ai',
    storageBucket: 'game-questions-build-with-ai.appspot.com',
    iosBundleId: 'com.mahmoudalaa.buildWithAiWorkshop',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBoL1VURp74LnTpPNbIy6gaAuSCO9pWVn0',
    appId: '1:952072927002:web:0a84d0769f947befd45ea3',
    messagingSenderId: '952072927002',
    projectId: 'game-questions-build-with-ai',
    authDomain: 'game-questions-build-with-ai.firebaseapp.com',
    storageBucket: 'game-questions-build-with-ai.appspot.com',
  );
}
