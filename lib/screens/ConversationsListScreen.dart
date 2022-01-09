import 'package:flutter/material.dart';
import 'package:tabbychat_ui_flutter/dao/chatDao.dart';
import 'package:tabbychat_ui_flutter/model/conversation.dart';
import 'package:tabbychat_ui_flutter/screens/ConversationScreen.dart';
import 'package:tabbychat_ui_flutter/widgets/ConversationList.dart';

class ConversationListScreen extends StatefulWidget {
  final ChatDao dao;

  ConversationListScreen({
    required this.dao,
    Key? key
  }): super(key: key);

  @override
  State<ConversationListScreen> createState() => _ConversationListScreenState();
}

class _ConversationListScreenState extends State<ConversationListScreen> {
  final List<Conversation> _conversations = [];

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  void _loadState() async {
    final conversations = await widget.dao.getConversations();
    setState(() {
      _conversations.clear();
      _conversations.addAll(conversations);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TabbyChat")
      ),
      body: ConversationList(
          conversations: _conversations,
        handleConversationPressed: (conversation) => Navigator.push(context, _createChatRoute(conversation))
      )
    );
  }

  Route _createChatRoute(Conversation conversation) => PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ChatScreen(conversation: conversation, dao: widget.dao),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    }
  );
}



