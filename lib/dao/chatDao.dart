import 'package:tabbychat_ui_flutter/model/conversation.dart';
import 'package:tabbychat_ui_flutter/model/dtos.dart';

abstract class ChatDao {

  Future<void> saveMessage(MessageDto message);
  Future<List<MessageDto>> getMessages(String conversationId);

  Future<void> saveUser(UserDto user);

  Future<void> saveConversation(ConversationDto conversation);
  Future<List<Conversation>> getConversations();

  Future<void> clear();
}