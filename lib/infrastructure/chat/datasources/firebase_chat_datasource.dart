import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_bott/infrastructure/chat/models/chat_session_model.dart';
import 'package:travel_bott/infrastructure/chat/models/message_model.dart';

@lazySingleton
class FirebaseChatDataSource {
  FirebaseChatDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  Future<List<ChatSessionModel>> getChatSessions(String userId) async {
    final snapshot = await _firestore
        .collection('chats')
        .where('userId', isEqualTo: userId)
        .orderBy('updatedAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => ChatSessionModel.fromJson(doc.data()..['id'] = doc.id))
        .toList();
  }

  Future<ChatSessionModel> createChatSession({
    required String userId,
    required String title,
  }) async {
    final now = DateTime.now();
    final docRef = await _firestore.collection('chats').add({
      'userId': userId,
      'title': title,
      'createdAt': now.toIso8601String(),
      'updatedAt': now.toIso8601String(),
    });

    final doc = await docRef.get();
    return ChatSessionModel.fromJson(doc.data()!..['id'] = doc.id);
  }

  Future<List<MessageModel>> getMessages(String sessionId) async {
    final snapshot = await _firestore
        .collection('chats')
        .doc(sessionId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .get();

    return snapshot.docs
        .map((doc) => MessageModel.fromJson(doc.data()..['id'] = doc.id))
        .toList();
  }

  Future<MessageModel> sendMessage({
    required String sessionId,
    required MessageModel message,
  }) async {
    final docRef = await _firestore
        .collection('chats')
        .doc(sessionId)
        .collection('messages')
        .add(message.toJson());

    await _firestore.collection('chats').doc(sessionId).update({
      'updatedAt': DateTime.now().toIso8601String(),
    });

    final doc = await docRef.get();
    return MessageModel.fromJson(doc.data()!..['id'] = doc.id);
  }

  Stream<List<MessageModel>> watchMessages(String sessionId) {
    return _firestore
        .collection('chats')
        .doc(sessionId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => MessageModel.fromJson(doc.data()..['id'] = doc.id))
              .toList(),
        );
  }
}
