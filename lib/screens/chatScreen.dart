import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:tabbychat_ui_flutter/screens/contactListScreen.dart';
import 'package:tabbychat_ui_flutter/model/dtos.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat;
import 'package:uuid/uuid.dart';

class ChatScreen extends StatelessWidget {
  final ContactDto you;
  final ContactDto contact;
  final List<MessageDto> messages;

  ChatScreen({
    required this.you,
    required this.contact,
    required this.messages,
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: ContactItem(contact: contact),
      ),
      body: _ChatList(
        you: you.toUser(),
        contact: contact.toUser()
      )
  );
}

class _ChatList extends StatefulWidget {

  final chat.User you;
  final chat.User contact;

  _ChatList({
    required this.you,
    required this.contact
  });

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<_ChatList> {
  final List<chat.Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() async {
    final loaded = laurenMessages.toList();
    loaded.sort((m1, m2) => -m1.sent.compareTo(m2.sent));

    final messages = loaded
      .map((message) => message.toMessage(widget.you, widget.contact))
      .toList();

    setState(() {
      _messages.addAll(messages);
    });
  }

  void _addMessage(chat.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(chat.PartialText message) {
    final textMessage = chat.TextMessage(
      author: widget.you,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) => Chat(
    messages: _messages,
    onSendPressed: _handleSendPressed,
    user: widget.you,
    showUserAvatars: true,
    showUserNames: true,
  );
}

extension ContactDtoChatExtensions on ContactDto {
  chat.User toUser() => chat.User(
    id: id,
    firstName: name.first,
    lastName: name.last,
    imageUrl: icon
  );
}

extension MessageDtoChatExtensions on MessageDto {

  chat.Message toMessage(chat.User you, chat.User contact) {
    final user = senderId == you.id ? you : contact;

    if (content.text != null) {
      return chat.TextMessage(
          id: id,
          createdAt: sent.millisecondsSinceEpoch,
          author: user,
          text: content.text!
      );
    }

    return chat.UnsupportedMessage(
      id: id,
      author: user,
      createdAt: sent.millisecondsSinceEpoch,
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Chat Sample',
    home: ChatScreen(
        you: you,
        contact: lauren,
        messages: laurenMessages
    )
  ));
}