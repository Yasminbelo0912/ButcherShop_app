import 'package:acougue_app/models/user.dart';
import 'package:acougue_app/services/user_service.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManager extends ChangeNotifier {
  UserService userService = UserService();
  User? _currentUser;
  User? get currentUser => _currentUser;

  Future<void> getUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userEmail = prefs.getString('userEmail');
    if (userEmail != null) {
      _currentUser = userService.getUserByEmail(userEmail);
      notifyListeners();
    }
  }

  Future<bool> isloggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('userLoggedIn') ?? false;
  }

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw 'Por favor, preencha tos os campos';
    }
    User? user = await userService.authenticate(email, password);
    if (user != null) {
      _currentUser = user;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userEmail', user.email);
      prefs.setBool('userLoggedIn', true);
      notifyListeners();
    } else {
      throw "Usuário ou senha incorretos";
    }
  }

  void logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("userLoggedIn", false);
    prefs.remove("userEmail");
    notifyListeners();
  }
}
