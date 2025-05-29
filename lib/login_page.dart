import 'package:flutter/material.dart';
import 'home_page.dart';
import 'secure_storage_service.dart';

class LoginPage extends StatelessWidget {
  final SecureStorageService storage = SecureStorageService();
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  LoginPage({super.key});

  void _login(BuildContext context) async {
    final username = userCtrl.text.trim();
    final password = passCtrl.text.trim();

    // Validación de credenciales simulada
    if (username == 'admin' && password == '1234') {
      await storage.saveToken("fake_token_123");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Credenciales inválidas"),
          content: const Text("Usuario o contraseña incorrectos. Intenta con admin / 1234."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userCtrl,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _login(context),
              child: const Text("Iniciar sesión"),
            ),
          ],
        ),
      ),
    );
  }
}
