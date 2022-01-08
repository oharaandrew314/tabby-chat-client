import 'package:flutter/material.dart';

import 'package:tabbychat_ui_flutter/screens/contactListScreen.dart';
import 'package:tabbychat_ui_flutter/model/dtos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TabbyChat',
      home: ContactListScreen(contacts: sampleContacts)
    );
  }
}


