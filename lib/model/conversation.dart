import 'package:tabbychat_ui_flutter/model/dtos.dart';

class Conversation {
  final String id;
  final String name;
  final UserDto you;
  final List<UserDto> users;

  Conversation({
    required this.id,
    required this.name,
    required this.you,
    required this.users
  });
}