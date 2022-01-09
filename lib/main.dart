import 'package:flutter/material.dart';
import 'package:tabbychat_ui_flutter/dao/chatDao.dart';
import 'package:tabbychat_ui_flutter/dao/profileDao.dart';
import 'package:tabbychat_ui_flutter/dao/sqlChatDao.dart';
import 'package:tabbychat_ui_flutter/model/dtos.dart';
import 'package:tabbychat_ui_flutter/model/profile.dart';

import 'package:tabbychat_ui_flutter/screens/ConversationsListScreen.dart';

void main() async {
  final chatDao = await SqlChatDao.create();
  final profileDao = await PrefsProfileDao.create();

  var profile = profileDao.getProfile();
  if (profile == null) {
    profile = Profile(
        userId: sampleYou.id,
        token: 'token1',
        realm: 'http://localhost:8000'
    );
    profileDao.setProfile(profile);

    await chatDao.clear();
    await chatDao.saveUser(sampleYou);
    await chatDao.saveUser(lauren);
    await chatDao.saveUser(josh);
    await chatDao.saveUser(kal);
    await chatDao.saveUser(toggles);

    for (final conversation in sampleConversations) {
      await chatDao.saveConversation(conversation);
    }
  }

  runApp(TabbyChatApp(dao: chatDao, profile: profile));
}

class TabbyChatApp extends StatelessWidget {
  final ChatDao dao;
  final Profile profile;

  TabbyChatApp({
    required this.dao,
    required this.profile
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TabbyChat',
      home: ConversationListScreen(
        profile: profile,
        dao: dao
      )
    );
  }
}


