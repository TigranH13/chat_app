// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      sendby: json['sendby'] as String,
      message: json['message'] as String,
      time: json['time'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'type': instance.type,
      'sendby': instance.sendby,
      'time': instance.time,
      'message': instance.message,
    };
