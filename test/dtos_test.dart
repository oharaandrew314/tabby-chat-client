import 'package:flutter_test/flutter_test.dart';
import 'package:tabbychat_ui_flutter/dtos.dart';
import 'package:tabbychat_ui_flutter/dtoExtensions.dart';

void main() {
  test('displayName of contact without middle name', () {
    final contact = ContactDto(id: "123", name: RealNameDto(first: "John", last: "Smith"));

    expect(contact.displayName(), "John Smith");
  });

  test('displayName of contact with middle name', () {
    final contact = ContactDto(id: "123", name: RealNameDto(first: "John", middle: "Frank", last: "Smith"));

    expect(contact.displayName(), "John Frank Smith");
  });
}