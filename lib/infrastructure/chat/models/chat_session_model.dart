import 'package:json_annotation/json_annotation.dart';
import 'package:travel_bott/domain/chat/entities/chat_session.dart';

part 'chat_session_model.g.dart';

@JsonSerializable()
class ChatSessionModel extends ChatSession {
  const ChatSessionModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ChatSessionModel.fromJson(Map<String, dynamic> json) =>
      _$ChatSessionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChatSessionModelToJson(this);

  factory ChatSessionModel.fromDomain(ChatSession session) {
    return ChatSessionModel(
      id: session.id,
      userId: session.userId,
      title: session.title,
      createdAt: session.createdAt,
      updatedAt: session.updatedAt,
    );
  }

  ChatSession toDomain() {
    return ChatSession(
      id: id,
      userId: userId,
      title: title,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
