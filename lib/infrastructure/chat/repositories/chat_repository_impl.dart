import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_bott/domain/chat/entities/chat_session.dart';
import 'package:travel_bott/domain/chat/entities/message.dart';
import 'package:travel_bott/domain/chat/repositories/i_chat_repository.dart';
import 'package:travel_bott/domain/core/failures/failure.dart';
import 'package:travel_bott/infrastructure/chat/datasources/firebase_chat_datasource.dart';
import 'package:travel_bott/infrastructure/chat/models/message_model.dart';
import 'package:travel_bott/infrastructure/user/datasources/firebase_user_datasource.dart';

@LazySingleton(as: IChatRepository)
class ChatRepositoryImpl implements IChatRepository {
  ChatRepositoryImpl(this._chatDataSource, this._userDataSource);

  final FirebaseChatDataSource _chatDataSource;
  final FirebaseUserDataSource _userDataSource;

  @override
  Future<Either<Failure, List<ChatSession>>> getChatSessions() async {
    try {
      final user = await _userDataSource.getCurrentUser();
      if (user == null) return left(const AuthFailure('User not found'));

      final models = await _chatDataSource.getChatSessions(user.id);
      return right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatSession>> createChatSession(String title) async {
    try {
      final user = await _userDataSource.getCurrentUser();
      if (user == null) return left(const AuthFailure('User not found'));

      final model = await _chatDataSource.createChatSession(
        userId: user.id,
        title: title,
      );
      return right(model.toDomain());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Message>>> getMessages(String sessionId) async {
    try {
      final models = await _chatDataSource.getMessages(sessionId);
      return right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Message>> sendMessage({
    required String sessionId,
    required String content,
  }) async {
    try {
      final messageModel = MessageModel(
        id: '',
        content: content,
        role: MessageRole.user,
        createdAt: DateTime.now(),
      );

      final model = await _chatDataSource.sendMessage(
        sessionId: sessionId,
        message: messageModel,
      );
      return right(model.toDomain());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Message>>> watchMessages(String sessionId) {
    return _chatDataSource
        .watchMessages(sessionId)
        .map(
          (models) => right<Failure, List<Message>>(
            models.map((m) => m.toDomain()).toList(),
          ),
        )
        .handleError(
          (e) => left<Failure, List<Message>>(ServerFailure(e.toString())),
        );
  }
}
