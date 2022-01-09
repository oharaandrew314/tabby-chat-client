import 'package:tabbychat_ui_flutter/model/dtos.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat;

extension ContactDtoChatExtensions on UserDto {
  chat.User toUser() => chat.User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      imageUrl: iconUri
  );
}