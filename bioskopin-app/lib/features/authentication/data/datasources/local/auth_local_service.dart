// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:bioskopin/core/entities/user.dart';

class AuthLocalService {
  final SharedPreferences _sharedPreferences;

  AuthLocalService(this._sharedPreferences);

  Future<void> saveUser(User user) async {
    Map<String, dynamic> userData = {
      'name': user.name,
      'email': user.email,
      'token': user.token,
    };

    String userJson = jsonEncode(userData);

    await _sharedPreferences.setString('user', userJson);
  }

  Future<User?> getUser() async {
    String? userJson = _sharedPreferences.getString('user');

    if (userJson != null && userJson.isNotEmpty) {
      Map<String, dynamic> userData = jsonDecode(userJson);

      return User(
        name: userData['name'],
        email: userData['email'],
        token: userData['token'],
      );
    } else {
      return null;
    }
  }

  Future<void> removeUser() async {
    await _sharedPreferences.remove('user');
  }
}
