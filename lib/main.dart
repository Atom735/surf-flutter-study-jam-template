import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'data/chat/repository/firebase.dart';
import 'firebase_options.dart';
import 'screens/chat.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform(
      androidKey: 'AIzaSyCXU5f25S_SUeVv7cAzoeF373kHk4Hv2dE',
      iosKey: 'AIzaSyAjvNoe31ZMSakjKFOkhbrZBsj3RyW6plo',
      webKey: 'AIzaSyD40PR_fizjSYtCZEtXgwq_5LdJu2w2zIs',
      windowsKey: 'AIzaSyD40PR_fizjSYtCZEtXgwq_5LdJu2w2zIs',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatRepository = ChatRepositoryFirebase(FirebaseFirestore.instance);

    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: ChatScreen(
        chatRepository: chatRepository,
      ),
    );
  }
}
