import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

enum MessageRole { user, assistant, system }

@JsonSerializable()
class Message extends Equatable {
  const Message({
    required this.id,
    required this.content,
    required this.role,
    required this.createdAt,
    this.metadata,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  final String id;
  final String content;
  final MessageRole role;
  final DateTime createdAt;
  final Map<String, dynamic>? metadata;

  @override
  List<Object?> get props => [id, content, role, createdAt, metadata];
}
