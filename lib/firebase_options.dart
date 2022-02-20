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
  static FirebaseOptions currentPlatform({
    required String webKey,
    required String iosKey,
    required String androidKey,
    required String windowsKey,
  }) {
    if (kIsWeb) {
      return web(webKey);
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.windows:
        return windows(windowsKey);
      case TargetPlatform.android:
        return android(androidKey);
      case TargetPlatform.iOS:
        return ios(iosKey);
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported'
          ' (${defaultTargetPlatform.name}).',
        );
    }
  }

  static FirebaseOptions windows(String apiKey) => FirebaseOptions(
        apiKey: apiKey,
        appId: '1:733105866417:web:c5e6c12528326f5f42c490',
        messagingSenderId: '733105866417',
        projectId: 'flutter-study-jam-chat',
        authDomain: 'flutter-study-jam-chat.firebaseapp.com',
        storageBucket: 'flutter-study-jam-chat.appspot.com',
      );

  static FirebaseOptions web(String apiKey) => FirebaseOptions(
        apiKey: apiKey,
        appId: '1:733105866417:web:c5e6c12528326f5f42c490',
        messagingSenderId: '733105866417',
        projectId: 'flutter-study-jam-chat',
        authDomain: 'flutter-study-jam-chat.firebaseapp.com',
        storageBucket: 'flutter-study-jam-chat.appspot.com',
      );

  static FirebaseOptions android(String apiKey) => FirebaseOptions(
        apiKey: apiKey,
        appId: '1:733105866417:android:3c79422507496dca42c490',
        messagingSenderId: '733105866417',
        projectId: 'flutter-study-jam-chat',
        storageBucket: 'flutter-study-jam-chat.appspot.com',
      );

  static FirebaseOptions ios(String apiKey) => FirebaseOptions(
        apiKey: apiKey,
        appId: '1:733105866417:ios:c7bd9f729a6c6aeb42c490',
        messagingSenderId: '733105866417',
        projectId: 'flutter-study-jam-chat',
        storageBucket: 'flutter-study-jam-chat.appspot.com',
        iosClientId:
            '733105866417-b913tlsk16lvctktgpia2nrejljo91f3.apps.googleusercontent.com',
        iosBundleId: 'com.example.surfPracticeChatFlutter',
      );
}
