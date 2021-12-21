import 'package:flutter/material.dart';
import 'package:tabbychat_ui_flutter/chat.dart';

import 'package:tabbychat_ui_flutter/dtos.dart';
import "package:tabbychat_ui_flutter/dtoExtensions.dart";

class ContactListPage extends StatelessWidget {
  final List<ContactDto> contacts;

  ContactListPage({required this.contacts, Key? key}): super(key: key);

  @override
  Widget build(BuildContext contact) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TabbyChat")
      ),
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (_, index) {
            return ContactItem(contact: contacts[index]);
          }
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final ContactDto contact;

  ContactItem({required this.contact, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) {
                    return ChatPage(contact: contact, messages: sampleMessages);
                  }
              )
          );
        },
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