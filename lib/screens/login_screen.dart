import 'package:acougue_app/managers/user_manager.dart';
import 'package:acougue_app/screens/home_admin_screen.dart';
import 'package:acougue_app/screens/home_employee_screen.dart';
import 'package:acougue_app/screens/home_screen.dart';
import 'package:acougue_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  String? erroText;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double widthDesired = width > 600 ? 600 : width * 0.9;

    final userManager = Provider.of<UserManager>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Container(
            width: widthDesired,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (erroText != null) ...[
                  Text(erroText!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 10),
                ],
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                ),
                SizedBox(height: 15),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          erroText = null;
                          isLoading = true;
                        });
                        try {
                          final userType = await userManager.login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                          await userManager.login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );

                          if (!mounted) return;

                          if (userType == "admin") {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const HomeAdminScreen(),
                              ),
                            );
                          } else if (userType == "funcionario") {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const HomeScreen(),
                              ),
                            );
                          } else {
                            throw "Tipo de funcionário desconhecido";
                          }
                        } catch (e) {
                          setState(() {
                            erroText = e.toString();
                          });
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: const Text("Entrar"),
                    ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: const Text("Não tem conta? Cadastra-se"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
