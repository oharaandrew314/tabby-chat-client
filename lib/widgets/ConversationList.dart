import 'package:flutter/widgets.dart';
import 'package:tabbychat_ui_flutter/model/conversation.dart';
import 'package:tabbychat_ui_flutter/model/profile.dart';
import 'package:tabbychat_ui_flutter/widgets/conversationHeader.dart';

class ConversationList extends StatelessWidget {
  final Profile profile;
  final List<Conversation> conversations;
  final Function(Conversation)? handleConversationPressed;

  ConversationList({
    required this.profile,
    required this.conversations,
    this.handleConversationPressed,
    Key? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (_, index) {
          final conversation = conversations[index];
          return ConversationHeader(
            profile: profile,
            conversation: conversation,
            onPressed: () {
              if (handleConversationPressed != null) {
                handleConversationPressed!(conversation);
              }
            },
          );
        }
    );
  }
}