import 'dart:convert';

import 'package:acougue_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  List<User> _users = [];

  Future<void> init() async {
    await loadData();
  }

  User? getUserByEmail(String email) {
    try {
      return _users.firstWhere((user) => user.email == email);
    } catch (_) {
      return null;
    }
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('users');

    if (jsonString != null) {
      final List<dynamic> decodeList = jsonDecode(jsonString);
      _users = decodeList.map((item) => User.fromJson(item)).toList();
    }
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final usersListJson = _users.map((user) => user.toJson()).toList();
    prefs.setString('users', jsonEncode(usersListJson));
  }

  void addUser(User user) {
    _users.add(user);
    saveData();
  }

  List<User> get users => _users;

  User? authenticate(String email, String password) {
    try {
      return _users.firstWhere(
        (user) => user.email == email && user.password == password,
      );
    } catch (_) {
      return null;
    }
  }

  void removeUser(String id) {
    _users.removeWhere((user) => user.id == id);

    saveData();
  }

  Future<void> updateUser(User user) async {
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;

      await saveData();
    }
  }

  bool userExists(String email) {
    final exists = _users.any((user) => user.email == email);
    return exists;
  }
}
