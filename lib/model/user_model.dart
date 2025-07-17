import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';
@JsonSerializable()
class UserModel{
  final String? id;
  final String email;
  final String name;
  final String? photoUrl;

  UserModel({
    this.id,
    required this.email,
    required this.name,
    this.photoUrl,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static fromFirebase(User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      photoUrl: user.photoURL,
    );
  }
}
