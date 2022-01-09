import 'package:flutter/widgets.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:tabbychat_ui_flutter/model/conversation.dart';
import 'package:tabbychat_ui_flutter/widgets/chatExtensions.dart';
import 'package:tabbychat_ui_flutter/model/dtos.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat;

class ConversationView extends StatelessWidget {

  final Conversation conversation;
  final List<MessageDto> messages;
  final Function(chat.PartialText) handleSendPressed;

  ConversationView({
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
    user: conversation.you.toUser(),
    showUserAvatars: true,
    showUserNames: true,
  );

  chat.Message _createMessage(MessageDto message) {
    final author = message.authorId == conversation.you.id
        ? conversation.you
        : conversation.users.firstWhere((e) => e.id == message.authorId);

    if (message.contentType == "text/plain" && !message.remoteContent) {
      return chat.TextMessage(
          id: message.id,
          createdAt: message.sent?.millisecondsSinceEpoch,
          author: author.toUser(),
          text: message.content
      );
    }

    return chat.UnsupportedMessage(
      id: message.id,
      author: author.toUser(),
      createdAt: message.sent?.millisecondsSinceEpoch,
    );
  }
}
