import 'package:tabbychat_ui_flutter/model/dtos.dart';

class Conversation {
  final String id;
  final String name;
  final List<UserDto> users;

  Conversation({
    required this.id,
    required this.name,
    required this.users
  });

  UserDto? getUser(String id) => users.firstWhere((e) => e.id == id, orElse: null);
}