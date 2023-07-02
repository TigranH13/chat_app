import 'package:json_annotation/json_annotation.dart';

part 'group_member.g.dart';

@JsonSerializable()
class GroupMember {
  final String name, email, avatarUrl;
  final bool isAdmin;

  GroupMember({
    required this.avatarUrl,
    required this.email,
    required this.name,
    required this.isAdmin,
  });

  factory GroupMember.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberFromJson(json);

  Map<String, dynamic> toJson() => _$GroupMemberToJson(this);
}
