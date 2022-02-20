import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';
import '../chat/chat_repository_firebase_impl.dart';
import '../chat/chat_repository_interface.dart';
import 'service_interface.dart';

class ServiceWindowsImpl implements IService {
  @override
  late final Future<String?> initFuture = () async {
    try {
      firebaseApp = await firebaseInitFuture;
      chatRepo = ChatRepositoryFirebaseImpl(FirebaseFirestore.instance);
      return null;
    } on Object catch (e) {
      return e.toString();
    }
  }();

  @override
  void dispose() {
    firebaseInitFuture.then((value) => value.delete());
  }

  late final firebaseInitFuture = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform(
      androidKey: 'AIzaSyCXU5f25S_SUeVv7cAzoeF373kHk4Hv2dE',
      iosKey: 'AIzaSyAjvNoe31ZMSakjKFOkhbrZBsj3RyW6plo',
      webKey: 'AIzaSyD40PR_fizjSYtCZEtXgwq_5LdJu2w2zIs',
      windowsKey: 'AIzaSyD40PR_fizjSYtCZEtXgwq_5LdJu2w2zIs',
    ),
  );

  late FirebaseApp firebaseApp;
  late IChatRepository chatRepo;
}
