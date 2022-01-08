import 'package:flutter/material.dart';
import 'package:tabbychat_ui_flutter/screens/chatScreen.dart';

import 'package:tabbychat_ui_flutter/model/dtos.dart';
import 'package:tabbychat_ui_flutter/model/dtoExtensions.dart';

class ContactListScreen extends StatelessWidget {
  final List<ContactDto> contacts;

  ContactListScreen({required this.contacts, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TabbyChat")
      ),
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (_, index) {
            final contact = contacts[index];
            return ContactItem(
                contact: contact,
              onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) {
                        return ChatScreen(you: you, contact: contact, messages: sampleMessages);
                        // return ChatPage(contact: contact, messages: sampleMessages);
                      }
                  )
              );
            },
            );
          }
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final ContactDto contact;
  final VoidCallback? onPressed;

  ContactItem({
    required this.contact,
    this.onPressed,
    Key? key
  }
      ): super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  key: Key(contact.id),
                  children: [
                    ContactIcon(contact: contact),
                    Text(contact.displayName()),
                  ],
                )
            )
          ],
        ),
    );
  }
}

class ContactIcon extends StatelessWidget {
  final ContactDto contact;

  ContactIcon({required this.contact, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget widget;
    if (contact.icon != null) {
      widget = Image.network(contact.icon!);
    } else {
      widget = Text(contact.displayName());
    }

    return CircleAvatar(
        key: Key("${contact.id}-avatar"),
        child: widget
    );
  }
}