import 'package:flutter/material.dart';
import 'package:tabbychat_ui_flutter/dao/chatDao.dart';
import 'package:tabbychat_ui_flutter/model/conversation.dart';
import 'package:tabbychat_ui_flutter/model/dtos.dart';
import 'package:tabbychat_ui_flutter/widgets/conversationView.dart';
import 'package:tabbychat_ui_flutter/widgets/conversationHeader.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat;
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  final Conversation conversation;
  final ChatDao dao;

  ChatScreen({
    required this.conversation,
    required this.dao,
    Key? key,
  }): super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<MessageDto> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadConversation();
  }

  void _loadConversation() async {
    final messages = await widget.dao.getMessages(widget.conversation.id);

    setState(() {
      _messages.clear();
      _messages.addAll(messages);
    });
  }

  void _addMessage(MessageDto message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(chat.PartialText data) {
    final message = MessageDto(
        id: Uuid().v4(),
        authorId: widget.conversation.you.id,
        conversationId: widget.conversation.id,
        created: DateTime.now(),
        contentType: 'text/plain',
        content: data.text
    );

    widget.dao.saveMessage(message);
    _addMessage(message);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: ConversationHeader(conversation: widget.conversation),
      ),
      body: ConversationView(
        conversation: widget.conversation,
        messages: _messages,
        handleSendPressed: _handleSendPressed,
      )
  );
}