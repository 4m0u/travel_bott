import 'package:json_annotation/json_annotation.dart';
import 'package:travel_bott/domain/user/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.name,
    super.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromDomain(UserEntity user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      photoUrl: user.photoUrl,
    );
  }

  UserEntity toDomain() {
    return UserEntity(id: id, email: email, name: name, photoUrl: photoUrl);
  }
}
