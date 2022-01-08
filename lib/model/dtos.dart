import 'package:flutter/services.dart';

class ContactDto {
  final String id;
  final RealNameDto name;
  final String? icon;

  ContactDto({
    required this.id,
    required this.name,
    this.icon
  });
}

class RealNameDto {
  final String first;
  final String? middle;
  final String? last;

  RealNameDto({
    required this.first,
    this.middle,
    this.last
  });
}

class MessageDto {
  final String id;
  final String senderId;
  final String recipientId;
  final DateTime sent;
  final DateTime? received;
  final MessageContentDto content;

  MessageDto({
    required this.id,
    required this.senderId,
    required this.recipientId,
    required this.sent,
    required this.received,
    required this.content
  });
}

class MessageContentDto {
  final String? text;
  final ByteData? image;

  MessageContentDto({
    this.text,
    this.image
  });
}

final sampleMessages = [
  MessageDto(id: "message1", senderId: "user1", recipientId: "user2", sent: DateTime.now(), received: DateTime.now(),content: MessageContentDto(text: "hai!")),
  MessageDto(id: "message2", senderId: "user2", recipientId: "user1", sent: DateTime.now(), received: DateTime.now(),content: MessageContentDto(text: "sup"))
];

final you = ContactDto(id: "user1", name: RealNameDto(first: "Andrew", last: "O'Hara"), icon: null);
final lauren = ContactDto(id: "user2", name: RealNameDto(first: "Lauren", middle: "Isabel", last: "Hepburn"), icon: "https://www.pikpng.com/pngl/m/124-1248296_muffin-clipart-banana-muffin-banana-muffin-clipart-png.png");

final laurenMessages = [
  MessageDto(id: "message1", senderId: you.id, recipientId: lauren.id, sent: DateTime(2022, 1, 1, 12, 0, 0), received: DateTime.now(), content: MessageContentDto(text: "hai!")),
  MessageDto(id: "message2", senderId: lauren.id, recipientId: you.id, sent: DateTime(2022, 1, 1, 12, 0, 10), received: DateTime.now(),content: MessageContentDto(text: "sup")),
  MessageDto(id: "message3", senderId: lauren.id, recipientId: you.id, sent: DateTime(2022, 1, 1, 12, 0, 20), received: DateTime.now(),content: MessageContentDto()),
  MessageDto(id: "message3", senderId: you.id, recipientId: lauren.id, sent: DateTime(2022, 1, 3, 3, 0, 0), received: DateTime.now(),content: MessageContentDto(text: "stuff"))
];

final sampleContacts = [
  lauren,
  ContactDto(id: "user3", name: RealNameDto(first: "Josh", last: "Phillips"), icon: "https://static.thenounproject.com/png/2643420-200.png"),
  ContactDto(id: "user4", name: RealNameDto(first: "Kal", last: "Hawari"), icon: "https://i.pinimg.com/736x/73/f7/00/73f700ce3b1e34b0eeeed6ffa8fb87c4.jpg"),
  ContactDto(id: "user0", name: RealNameDto(first: "Toggles", last: "Brown"), icon: "https://pbs.twimg.com/media/FHK1ARmWQAsejZ4?format=jpg&name=small")
];