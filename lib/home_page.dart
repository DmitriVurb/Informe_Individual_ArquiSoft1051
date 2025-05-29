import 'package:flutter/material.dart';
import 'login_page.dart';
import 'secure_storage_service.dart';

class HomePage extends StatelessWidget {
  final SecureStorageService storage = SecureStorageService();

  HomePage({super.key});

  void _logout(BuildContext context) async {
    await storage.deleteToken();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  void _mostrarTokenEnConsola() async {
    final token = await storage.readToken();
    print('🔐 Token almacenado: $token');
  }

  void _mostrarTokenEnPantalla(BuildContext context) async {
    final token = await storage.readToken();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Token guardado'),
        content: Text(token ?? 'No hay token'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Muestra automáticamente el token en consola cada vez que se construye la vista
    _mostrarTokenEnConsola();

    return Scaffold(
      appBar: AppBar(title: const Text("Inicio")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("¡Sesión activa!"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _logout(context),
              child: const Text("Cerrar sesión"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _mostrarTokenEnPantalla(context),
              child: const Text("Mostrar token"),
            ),
          ],
        ),
      ),
    );
  }
}
