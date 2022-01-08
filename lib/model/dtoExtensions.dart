import 'package:tabbychat_ui_flutter/model/dtos.dart';

extension ContactDtoExtensions on ContactDto {
  String displayName() {
    final buffer = StringBuffer();
    buffer.write(name.first);
    if (name.middle != null) {
      buffer.write(" ");
      buffer.write(name.middle);
    }
    buffer.write(" ");
    buffer.write(name.last);

    return buffer.toString();
  }
}