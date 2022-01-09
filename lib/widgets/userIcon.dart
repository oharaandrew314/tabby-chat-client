import 'package:flutter/material.dart';
import 'package:tabbychat_ui_flutter/model/dtos.dart';

class UserIcon extends StatelessWidget {
  final UserDto user;

  UserIcon({required this.user, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget widget;
    if (user.iconUri != null) {
      widget = Image.network(user.iconUri!);
    } else {
      widget = Text(user.firstName);
    }

    return CircleAvatar(
        key: Key("${user.id}-avatar"),
        child: widget
    );
  }
}