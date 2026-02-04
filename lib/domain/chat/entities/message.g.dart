// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
  id: json['id'] as String,
  content: json['content'] as String,
  role: $enumDecode(_$MessageRoleEnumMap, json['role']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'role': _$MessageRoleEnumMap[instance.role]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'metadata': instance.metadata,
};

const _$MessageRoleEnumMap = {
  MessageRole.user: 'user',
  MessageRole.assistant: 'assistant',
  MessageRole.system: 'system',
};
