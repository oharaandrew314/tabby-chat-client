import 'package:flutter/material.dart';

import 'package:tabbychat_ui_flutter/dtos.dart';
import "package:tabbychat_ui_flutter/dtoExtensions.dart";

class ChatPage extends StatelessWidget {
  final ContactDto contact;
  final List<MessageDto> messages;

  ChatPage({
    required this.contact,
    required this.messages,
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.displayName()),
      ),
      body: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (_, index) {
            return MessageItem(message: messages[index]);
          }
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  final MessageDto message;

  MessageItem({
    required this.message,
    Key? key
}): super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget content;
    final text = message.content.text;
    final image = message.content.image;
    
    if (text != null) {
      content = Text(text);
    } else if (image != null){
      content = Image.memory(image.buffer.asUint8List());
    } else {
      content = Text("No content");
    }

    return Container(
      key: Key(message.received.toString()),
      child: content,
    );
  }
}