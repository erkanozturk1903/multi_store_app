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
    apiKey: 'AIzaSyBHs_DPN9PHw2C1gKr93PoYXDX1GBd3I3o',
    appId: '1:37699514273:android:7a6fe787290848fd9aa5e0',
    messagingSenderId: '37699514273',
    projectId: 'multi-store-ea764',
    storageBucket: 'multi-store-ea764.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDQMK_xMuq35qD_MP4EmKaqFV98BBqz0oc',
    appId: '1:37699514273:ios:be11c4fcdc2417039aa5e0',
    messagingSenderId: '37699514273',
    projectId: 'multi-store-ea764',
    storageBucket: 'multi-store-ea764.appspot.com',
    androidClientId: '37699514273-pg1jg0rqklbmpm2ie1cqa3faujfb5vli.apps.googleusercontent.com',
    iosClientId: '37699514273-o9i4qqck5m0dc51qbburpf7uut9eo22c.apps.googleusercontent.com',
    iosBundleId: 'com.erkanozturk1903.multiStoreApp',
  );
}
