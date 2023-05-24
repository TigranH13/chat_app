// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class NewUser {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  NewUser({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  factory NewUser.fromJson(Map<String, dynamic> json) =>
      _$NewUserFromJson(json);

  Map<String, dynamic> toJson() => _$NewUserToJson(this);
}
