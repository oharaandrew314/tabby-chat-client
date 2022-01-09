import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabbychat_ui_flutter/model/profile.dart';

abstract class ProfileDao {
  Profile? getProfile();
  void setProfile(Profile profile);
}

class PrefsProfileDao implements ProfileDao {
  final SharedPreferences prefs;

  PrefsProfileDao({
    required this.prefs
  });

  static Future<ProfileDao> create() async {
    final prefs = await SharedPreferences.getInstance();

    return PrefsProfileDao(prefs: prefs);
  }

  @override
  Profile? getProfile() {
    final userId = prefs.getString('userId');
    final token = prefs.getString('token');
    final realm = prefs.getString('realm');

    if (userId == null || token == null || realm == null) return null;

    return Profile(
        userId: userId,
        token: token,
        realm: realm
    );
  }

  @override
  void setProfile(Profile profile) {
    prefs.setString('userId', profile.userId);
    prefs.setString('token', profile.token);
    prefs.setString('realm', profile.realm);
  }
}