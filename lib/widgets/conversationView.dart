import 'package:flutter/widgets.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:tabbychat_ui_flutter/model/conversation.dart';
import 'package:tabbychat_ui_flutter/model/dtos.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat;
import 'package:tabbychat_ui_flutter/model/profile.dart';

class ConversationView extends StatelessWidget {

  final Profile profile;
  final Conversation conversation;
  final List<MessageDto> messages;
  final Function(chat.PartialText) handleSendPressed;

  ConversationView({
    required this.profile,
    required this.conversation,
    required this.messages,
    required this.handleSendPressed,
    Key? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) => Chat(
    messages: messages
        .map((message) => _createMessage(message))
        .toList(),
    onSendPressed: handleSendPressed,
    user: toUser(conversation.getUser(profile.userId)!),
    showUserAvatars: true,
    showUserNames: true,
  );

  chat.Message _createMessage(MessageDto message) {
    final author = conversation.getUser(message.authorId)!;

    if (message.contentType == "text/plain" && !message.remoteContent) {
      return chat.TextMessage(
          id: message.id,
          createdAt: message.sent?.millisecondsSinceEpoch,
          author: toUser(author),
          text: message.content
      );
    }

    return chat.UnsupportedMessage(
      id: message.id,
      author: toUser(author),
      createdAt: message.sent?.millisecondsSinceEpoch,
    );
  }

  chat.User toUser(UserDto user) => chat.User(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      imageUrl: user.iconUri
  );
}
