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
  final String senderId;
  final String recipientId;
  final DateTime received;
  final MessageContentDto content;

  MessageDto({
    required this.senderId,
    required this.recipientId,
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

final List<MessageDto> sampleMessages = [
  MessageDto(senderId: "user1", recipientId: "user2", received: DateTime.now(), content: MessageContentDto(text: "hai!")),
  MessageDto(senderId: "user2", recipientId: "user1", received: DateTime.now(), content: MessageContentDto(text: "sup"))
];


final List<ContactDto> dtos = [
  ContactDto(id: "user2", name: RealNameDto(first: "Lauren", middle: "Isabel", last: "Hepburn"), icon: "https://www.pikpng.com/pngl/m/124-1248296_muffin-clipart-banana-muffin-banana-muffin-clipart-png.png"),
  ContactDto(id: "user3", name: RealNameDto(first: "Josh", last: "Phillips"), icon: "https://static.thenounproject.com/png/2643420-200.png"),
  ContactDto(id: "user4", name: RealNameDto(first: "Kal", last: "Hawari"), icon: "https://i.pinimg.com/736x/73/f7/00/73f700ce3b1e34b0eeeed6ffa8fb87c4.jpg"),
  ContactDto(id: "user0", name: RealNameDto(first: "Toggles", last: "Brown"), icon: "https://pbs.twimg.com/media/FHK1ARmWQAsejZ4?format=jpg&name=small")
];