import 'package:flutter/material.dart';
import 'package:tabbychat_ui_flutter/model/conversation.dart';
import 'package:tabbychat_ui_flutter/model/dtos.dart';
import 'package:tabbychat_ui_flutter/widgets/userIcon.dart';

class ConversationHeader extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback? onPressed;

  ConversationHeader({
    required this.conversation,
    this.onPressed,
    Key? key
  }
      ): super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserDto? primaryContact = conversation.users
        .firstWhere((u) => u.id != conversation.you.id, orElse: null);

    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                key: Key(conversation.id),
                children: [
                  if (primaryContact != null) UserIcon(user: primaryContact),
                  Text(conversation.name),
                ],
              )
          )
        ],
      ),
    );
  }
}