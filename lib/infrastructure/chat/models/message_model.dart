import 'package:json_annotation/json_annotation.dart';
import 'package:travel_bott/domain/chat/entities/message.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.content,
    required super.role,
    required super.createdAt,
    super.metadata,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  factory MessageModel.fromDomain(Message message) {
    return MessageModel(
      id: message.id,
      content: message.content,
      role: message.role,
      createdAt: message.createdAt,
      metadata: message.metadata,
    );
  }

  Message toDomain() {
    return Message(
      id: id,
      content: content,
      role: role,
      createdAt: createdAt,
      metadata: metadata,
    );
  }
}
