import 'package:flutter_test/flutter_test.dart';
import 'package:travel_bott/infrastructure/user/models/user_model.dart';
import 'package:travel_bott/domain/user/entities/user.dart';

void main() {
  const tUserModel = UserModel(
    id: '1',
    email: 'test@example.com',
    name: 'Test User',
    photoUrl: 'http://example.com/photo.jpg',
  );

  const tUserEntity = UserEntity(
    id: '1',
    email: 'test@example.com',
    name: 'Test User',
    photoUrl: 'http://example.com/photo.jpg',
  );

  group('UserModel', () {
    test('should be a subclass of UserEntity', () {
      expect(tUserModel, isA<UserEntity>());
    });

    test('fromDomain should return a valid model', () {
      final result = UserModel.fromDomain(tUserEntity);
      expect(result, tUserModel);
    });

    test('toDomain should return a valid entity', () {
      final result = tUserModel.toDomain();
      expect(result, tUserEntity);
    });

    test('fromJson should return a valid model', () {
      final Map<String, dynamic> jsonMap = {
        'id': '1',
        'email': 'test@example.com',
        'name': 'Test User',
        'photoUrl': 'http://example.com/photo.jpg',
      };
      final result = UserModel.fromJson(jsonMap);
      expect(result, tUserModel);
    });

    test('toJson should return a JSON map containing proper data', () {
      final result = tUserModel.toJson();
      final expectedJsonMap = {
        'id': '1',
        'email': 'test@example.com',
        'name': 'Test User',
        'photoUrl': 'http://example.com/photo.jpg',
      };
      expect(result, expectedJsonMap);
    });
  });
}
