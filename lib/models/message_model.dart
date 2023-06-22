import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class Message {
  final String type;
  final String sendby;
  final String time;
  final String message;

  Message(
      {required this.sendby,
      required this.message,
      required this.time,
      required this.type});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
