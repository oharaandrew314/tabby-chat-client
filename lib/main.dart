import 'package:flutter/material.dart';

import 'package:tabbychat_ui_flutter/contactList.dart';
import 'package:tabbychat_ui_flutter/dtos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TabbyChat',
      home: ContactListPage(contacts: dtos)
    );
  }
}


