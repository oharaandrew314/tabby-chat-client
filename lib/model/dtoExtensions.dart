import 'package:tabbychat_ui_flutter/model/dtos.dart';

extension UserDtoExtensions on UserDto {
  String displayName() {
    final buffer = StringBuffer();
    buffer.write(firstName);
    buffer.write(" ");
    buffer.write(lastName);

    return buffer.toString();
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "iconUri": iconUri
  };

  static UserDto fromJson(Map<String, dynamic> json) => UserDto(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName']
  );
}

extension MessageDtoExtensions on MessageDto {
  Map<String, dynamic> toJson() => {
      'id': id,
      'authorId': authorId,
      'conversationId': conversationId,
      'created': created,
      'sent': sent?.toIso8601String(),
      'received': received?.toIso8601String(),
      'contentType': contentType,
      'content': content
    };

  static MessageDto fromJson(Map<String, dynamic> json) => MessageDto(
      id: json['id'],
      authorId: json['authorId'],
      conversationId: json['conversationId'],
      created: DateTime.parse(json['created']),
      sent: json.containsKey('sent') ? DateTime.parse(json['sent']) : null,
      received: json.containsKey("received") ? DateTime.parse(json['received']): null,
      contentType: json['contentType'],
      content: json['content']
  );
}

extension ConversationDtoExtensions on ConversationDto {
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'userIds': userIds
  };

  static ConversationDto fromJson(Map<String, dynamic> json) => ConversationDto(
      id: json['id'],
      name: json['name'],
      userIds: json['userIds']
  );
}