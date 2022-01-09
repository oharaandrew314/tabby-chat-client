import 'package:flutter/material.dart';
import 'package:tabbychat_ui_flutter/dao/chatDao.dart';
import 'package:tabbychat_ui_flutter/dao/sqlChatDao.dart';
import 'package:tabbychat_ui_flutter/model/dtos.dart';
import 'package:tabbychat_ui_flutter/model/profile.dart';

import 'package:tabbychat_ui_flutter/screens/ConversationsListScreen.dart';

void main() async {
  final dao = await SqlChatDao.create();

  final profile = await dao.getProfile();
  if (profile == null) {
    await dao.setProfile(Profile(
        user: sampleYou,
        token: 'token1',
        realm: 'http://localhost:8000'
    ));

    await dao.saveUser(lauren);
    await dao.saveUser(josh);
    await dao.saveUser(kal);
    await dao.saveUser(toggles);

    for (final conversation in sampleConversations) {
      await dao.saveConversation(conversation);
    }
  }

  runApp(TabbyChatApp(dao: dao));
}

class TabbyChatApp extends StatelessWidget {
  final ChatDao dao;

  TabbyChatApp({
    required this.dao
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TabbyChat',
      home: ConversationListScreen(dao: dao)
    );
  }
}


