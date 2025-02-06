import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = AuthController();

    Future<void> onLogin(context) async {
      bool success = await authController.loginUser(
          emailController.text, passwordController.text);
      if (!success) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Erro ao fazer login. Verifique suas credenciais."),
            ),
          );
        }
      } else {
        Navigator.pushNamed(context, '/home');
      }
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Logo-IFPI-Vertical.png'),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onLogin(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              child: Text('Entrar', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              child: Text('Cadastrar Conta'),
            ),
          ],
        ),
      ),
    );
  }
}
