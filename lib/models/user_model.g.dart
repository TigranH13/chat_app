// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewUser _$NewUserFromJson(Map<String, dynamic> json) => NewUser(
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String,
    );

Map<String, dynamic> _$NewUserToJson(NewUser instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
    };
