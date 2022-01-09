import 'package:uuid/uuid.dart';

class UserDto {
  final String id;
  final String firstName;
  final String lastName;
  final String? iconUri;

  UserDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.iconUri
  });
}

class ConversationDto {
  final String id;
  final String name;
  final List<String> userIds;

  ConversationDto({
    required this.id,
    required this.name,
    required this.userIds
  });
}

// class MessagePageDto {
//   final List<MessageDto> messages;
//
//   MessagePageDto({
//     required this.messages
//   });
// }

class MessageDto {
  final String id;
  final String authorId;
  final String conversationId;
  final DateTime created;
  final DateTime? sent;
  final DateTime? received;
  final String contentType;
  final String content;
  final bool remoteContent;

  MessageDto({
    required this.id,
    required this.authorId,
    required this.conversationId,
    required this.created,
    this.sent,
    this.received,
    required this.contentType,
    required this.content,
    this.remoteContent = false
  });
}

final sampleConversations = [
  ConversationDto(id: Uuid().v4(), name: 'Lauren', userIds: [sampleYou.id, lauren.id]),
  ConversationDto(id: Uuid().v4(), name: "Toggles", userIds: [sampleYou.id, toggles.id])
];

final sampleMessages = [
  MessageDto(id: Uuid().v4(), authorId: "user1", conversationId: "user2", created: DateTime.now(), contentType: 'text/plain', content: 'hai!'),
  MessageDto(id: Uuid().v4(), authorId: "user2", conversationId: "user1", created: DateTime.now(), contentType: 'text/plain', content: 'sup')
];

final sampleYou = UserDto(id: Uuid().v4(), firstName: "Andrew", lastName: "O'Hara", iconUri: null);
final lauren = UserDto(id: Uuid().v4(), firstName: "Lauren", lastName: "Hepburn", iconUri: "https://www.pikpng.com/pngl/m/124-1248296_muffin-clipart-banana-muffin-banana-muffin-clipart-png.png");
final josh = UserDto(id: Uuid().v4(), firstName: "Josh", lastName: "Phillips", iconUri: "https://static.thenounproject.com/png/2643420-200.png");
final kal = UserDto(id: Uuid().v4(), firstName: "Kal", lastName: "Hawari", iconUri: "https://i.pinimg.com/736x/73/f7/00/73f700ce3b1e34b0eeeed6ffa8fb87c4.jpg");
final toggles = UserDto(id: Uuid().v4(), firstName: "Toggles", lastName: "Brown", iconUri: "https://pbs.twimg.com/media/FHK1ARmWQAsejZ4?format=jpg&name=small");

final laurenMessages = [
  MessageDto(id: Uuid().v4(), authorId: sampleYou.id, conversationId: lauren.id, created: DateTime(2022, 1, 1, 12, 0, 0), contentType: 'text/plain', content: 'hai!'),
  MessageDto(id: Uuid().v4(), authorId: lauren.id, conversationId: sampleYou.id, created: DateTime(2022, 1, 1, 12, 0, 10), contentType: 'text/plain', content: 'sup'),
  MessageDto(id: Uuid().v4(), authorId: lauren.id, conversationId: sampleYou.id, created: DateTime(2022, 1, 1, 12, 0, 20), contentType: 'foo/bar', content: ''),
  MessageDto(id: Uuid().v4(), authorId: sampleYou.id, conversationId: lauren.id, created: DateTime(2022, 1, 3, 3, 0, 0), contentType: 'text/plain', content: 'stuff')
];