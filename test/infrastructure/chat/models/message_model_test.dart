import 'package:flutter_test/flutter_test.dart';
import 'package:travel_bott/infrastructure/chat/models/message_model.dart';
import 'package:travel_bott/domain/chat/entities/message.dart';

void main() {
  final tCreatedAt = DateTime.parse('2024-02-04T12:00:00Z');
  
  final tMessageModel = MessageModel(
    id: '1',
    content: 'hello',
    role: MessageRole.user,
    createdAt: tCreatedAt,
  );

  final tMessageEntity = Message(
    id: '1',
    content: 'hello',
    role: MessageRole.user,
    createdAt: tCreatedAt,
  );

  group('MessageModel', () {
    test('should be a subclass of Message', () {
      expect(tMessageModel, isA<Message>());
    });

    test('fromDomain should return a valid model', () {
      final result = MessageModel.fromDomain(tMessageEntity);
      expect(result, tMessageModel);
    });

    test('toDomain should return a valid entity', () {
      final result = tMessageModel.toDomain();
      expect(result, tMessageEntity);
    });

    test('fromJson should return a valid model', () {
      final Map<String, dynamic> jsonMap = {
        'id': '1',
        'content': 'hello',
        'role': 'user',
        'createdAt': tCreatedAt.toIso8601String(),
      };
      final result = MessageModel.fromJson(jsonMap);
      expect(result, tMessageModel);
    });

    test('toJson should return a JSON map containing proper data', () {
      final result = tMessageModel.toJson();
      final expectedJsonMap = {
        'id': '1',
        'content': 'hello',
        'role': 'user',
        'createdAt': tCreatedAt.toIso8601String(),
        'metadata': null,
      };
      expect(result, expectedJsonMap);
    });
  });
}
