import 'package:acougue_app/managers/user_manager.dart';
import 'package:acougue_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double widthDesired = width > 600 ? 600 : width * 0.9;

    final _userService = UserService();
    final userManager = Provider.of<UserManager>(context);
  }
}
