import 'package:fpdart/fpdart.dart';
import 'package:travel_bott/domain/chat/entities/chat_session.dart';
import 'package:travel_bott/domain/chat/entities/message.dart';
import 'package:travel_bott/domain/core/failures/failure.dart';

abstract class IChatRepository {
  Future<Either<Failure, List<ChatSession>>> getChatSessions();
  Future<Either<Failure, ChatSession>> createChatSession(String title);
  Future<Either<Failure, List<Message>>> getMessages(String sessionId);
  Future<Either<Failure, Message>> sendMessage({
    required String sessionId,
    required String content,
  });
  Stream<Either<Failure, List<Message>>> watchMessages(String sessionId);
}
