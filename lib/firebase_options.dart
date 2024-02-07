import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4YGKh25xPp2XCbtLoECcAv3MaNe4zh2M',
    appId: '1:177858560734:android:91ca3e63abe4356557384f',
    messagingSenderId: '177858560734',
    projectId: 'flutter-firebase-01-23120',
    storageBucket: 'flutter-firebase-01-23120.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6wSkjhwczq-bojSAvb5Y3JH36KiU5Dm8',
    appId: '1:177858560734:ios:0110b26f3214c9b557384f',
    messagingSenderId: '177858560734',
    projectId: 'flutter-firebase-01-23120',
    storageBucket: 'flutter-firebase-01-23120.appspot.com',
    iosBundleId: 'com.example.quizAppTutorial',
  );
}
