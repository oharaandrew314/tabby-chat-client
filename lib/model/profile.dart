import 'package:tabbychat_ui_flutter/model/dtos.dart';

class Profile {
  final UserDto user;
  final String token;
  final String realm;

  Profile({
    required this.user,
    required this.token,
    required this.realm
  });
}