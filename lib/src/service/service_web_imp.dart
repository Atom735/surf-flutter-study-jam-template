import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../firebase_options.dart';
import '../chat/chat_message_data.dart';
import '../chat/chat_repository_firebase_impl.dart';
import '../chat/chat_repository_interface.dart';
import '../chat/chat_user_data.dart';
import '../common/geolocation_data.dart';
import 'service_interface.dart';

class ServiceWebImpl implements IService {
  @override
  late final Future<String?> initFuture = () async {
    try {
      sp = await SharedPreferences.getInstance();

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
      options:
          DefaultFirebaseOptions.web('AIzaSyAtMxD7Nb6Z06IL2yg8DbI56xoneVhXSNQ')
      //   androidKey: 'AIzaSyCXU5f25S_SUeVv7cAzoeF373kHk4Hv2dE',
      //   iosKey: 'AIzaSyAjvNoe31ZMSakjKFOkhbrZBsj3RyW6plo',
      //   webKey: 'AIzaSyD40PR_fizjSYtCZEtXgwq_5LdJu2w2zIs',
      //   windowsKey: 'AIzaSyD40PR_fizjSYtCZEtXgwq_5LdJu2w2zIs',
      // ),
      );

  late FirebaseApp firebaseApp;

  @override
  late IChatRepository chatRepo;

  @override
  late SharedPreferences sp;

  final _cachedMessages = SplayTreeSet<ChatMessageData>(_chatComparator);

  static int _chatComparator(ChatMessageData a, ChatMessageData b) {
    int i;
    i = b.timestamp.compareTo(a.timestamp);
    if (i != 0) return i;
    i = a.author.name.compareTo(b.author.name);
    if (i != 0) return i;
    i = a.message.compareTo(b.message);
    if (i != 0) return i;
    return 0;
  }

  @override
  Future<List<ChatMessageData>> getMessages() async {
    if (_cachedMessages.isEmpty) {
      _cachedMessages.addAll(await chatRepo.getMessages(512));
    } else {
      _cachedMessages.addAll(
          await chatRepo.getMessages(512, _cachedMessages.last.timestamp));
    }

    return _cachedMessages.toList();
  }

  @override
  Future<void> sendMessage(ChatMessageData data) => chatRepo.sendMessage(data);
}
