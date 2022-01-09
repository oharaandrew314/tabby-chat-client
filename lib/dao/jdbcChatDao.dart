import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tabbychat_ui_flutter/dao/chatDao.dart';
import 'package:tabbychat_ui_flutter/model/profile.dart';
import 'package:tabbychat_ui_flutter/model/conversation.dart';
import 'package:tabbychat_ui_flutter/model/dtos.dart';

class JdbcChatDao implements ChatDao {
  final DatabaseExecutor db;

  JdbcChatDao({
    required this.db
  });

  static const _createAuth = """
    CREATE TABLE auth (
      id CHAR(36) NOT NULL,
      realm TEXT NOT NULL,
      token TEXT NOT NULL,
     FOREIGN KEY(id) REFERENCES users(id)
    );
  """;

  static const _createUsers = """
    CREATE TABLE users (
      id CHAR(36) PRIMARY KEY NOT NULL,
      firstName VARCHAR(256) NOT NULL,
      lastName VARCHAR(256) NOT NULL,
      iconUri TEXT
    );
  """;

  static const _createMessages = """
    CREATE TABLE messages(
      id CHAR(36) PRIMARY KEY NOT NULL,
      authorId CHAR(36) NOT NULL,
      conversationId CHAR(36) NOT NULL,
      created DATETIME NOT NULL,
      sent DATETIME,
      received DATETIME,
      contentType VARCHAR(32) NOT NULL,
      content TEXT NOT NULL,
      
      FOREIGN KEY(authorId) REFERENCES users(id),
      FOREIGN KEY(conversationId) REFERENCES conversations(id)
    );
  """;

  static const _createConversations = """
    CREATE TABLE conversations(
      id CHAR(36) PRIMARY KEY NOT NULL,
      name VARCHAR(256) NOT NULL,
      userIds VARCHAR(1024) NOT NULL
    );
  """;

  static Future<ChatDao> create() async {
    WidgetsFlutterBinding.ensureInitialized();

    final db = await openDatabase(
      join(await getDatabasesPath(), "tabbychat.db"),
      onCreate: (db, version) async {
        await db.execute(_createAuth);
        await db.execute(_createUsers);
        await db.execute(_createConversations);
        await db.execute(_createMessages);
      },
      version: 1,
    );

    return JdbcChatDao(db: db);
  }

  Future<void> saveMessage(MessageDto message) async {
    await db.insert('messages', {
        'id': message.id,
        'authorId': message.authorId,
        'conversationId': message.conversationId,
        'created': message.created.toIso8601String(),
        'sent': message.sent?.toIso8601String(),
        'received': message.received?.toIso8601String(),
        'contentType': message.contentType,
        'content': message.content
      });
  }

  Future<void> saveUser(UserDto user) async {
    await db.insert(
        "users", {
          "id": user.id,
          "firstName": user.firstName,
          "lastName": user.lastName,
          "iconUri": user.iconUri
        },
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> saveConversation(ConversationDto conversation) async {
    await db.insert(
      "conversations",
      {
        'id': conversation.id,
        'name': conversation.name,
        'userIds': conversation.userIds.join(',')
      },
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> setProfile(Profile profile) async {
    await saveUser(profile.user);
    await db.insert(
        "auth",
        {
          'id': profile.user.id,
          'realm': profile.realm,
          'token': profile.token
        },
        conflictAlgorithm: ConflictAlgorithm.fail
      );
  }

  Future<Profile?> getProfile() async {
    final authRows = await db.query("auth", limit: 1);
    if (authRows.isEmpty) return null;

    final authRow = authRows.first;

    final userRows = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [authRow['id']],
      limit: 1
    );
    if (userRows.isEmpty) return null;

    return Profile(
        user: _toUserDto(userRows.first),
        token: authRow['token'] as String,
        realm: authRow['realm'] as String
    );
  }

  Future<List<Conversation>> getConversations() async {
    final profile = await getProfile();
    if (profile == null) return [];

    final userRows = await db.query("users");
    final users = userRows.map(_toUserDto);
    final Map<String, UserDto> usersById = Map.fromIterable(users, key: (i) => i.id, value: (i) => i);

    final conversationRows = await db.query("conversations");
    return conversationRows.map((row) =>
        Conversation(
            you: profile.user,
            id: row['id'] as String,
            name: row['name'] as String,
            users: (row['userIds'] as String)
              .split(',')
              .map((id) => usersById[id])
              .whereType<UserDto>()
              .toList()
        )
      ).toList();
  }

  Future<List<MessageDto>> getMessages(String conversationId) async {
    final results = await db.query(
      'messages',
      where: 'conversationId = ?',
      whereArgs: [conversationId],
      orderBy: 'created desc'
    );

    return results
        .map((row) =>
          MessageDto(
              id: row['id'] as String,
              authorId: row['authorId'] as String,
              conversationId: row['conversationId'] as String,
              created: DateTime.parse(row['created'] as String),
              sent: _toDateTime(row['sent']),
              received: _toDateTime(row['received']),
              contentType: row['contentType'] as String,
              content: row['content'] as String
          )
        )
        .toList();
  }

  UserDto _toUserDto(Map<String, dynamic> row) => UserDto(
    id: row['id'],
    firstName: row['firstName'],
    lastName: row['lastName']
  );

  DateTime? _toDateTime(Object? value) => value is String ? DateTime.parse(value) : null;

  @override
  Future<void> clear() async {
    await db.delete("auth");
    await db.delete("users");
    await db.delete("conversations");
    await db.delete("messages");
  }
}