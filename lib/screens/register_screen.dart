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
  final _formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLogged = false;
  String? errorText;
  String userType = 'funcionario';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double widthDesired = width > 600 ? 600 : width * 0.9;

    final _userService = UserService();
    final userManager = Provider.of<UserManager>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: widthDesired,
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: ListView(
              shrinkWrap: true,
              children: [
                if (errorText == null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      errorText!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'nome'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Digite seu nome'
                              : null,
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'email'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Digite seu email'
                              : null,
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'senha'),
                  validator:
                      (value) =>
                          value == null || value.length < 6
                              ? 'Mínimo de 6 caracteres'
                              : null,
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirme sua senha',
                  ),
                  validator:
                      (value) =>
                          value != passwordController.text
                              ? 'Senhas não coincidem'
                              : null,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Text(
                      "Tipo de usuário: ",
                      style: TextStyle(color: Colors.white),
                    ),
                    DropdownButton<String>(
                      value: userType,
                      dropdownColor: Colors.black,
                      iconDisabledColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      items: const [
                        DropdownMenuItem(
                          value: 'funcionario',
                          child: Text('funcionario'),
                        ),
                        DropdownMenuItem(
                          value: 'admin',
                          child: Text('Administrador'),
                        ),
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          userType = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
