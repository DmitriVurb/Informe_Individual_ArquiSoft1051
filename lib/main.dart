import 'package:flutter/material.dart';
import 'secure_storage_service.dart';
import 'home_page.dart';
import 'login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final SecureStorageService storage = SecureStorageService();

  MyApp({super.key});

  Future<Widget> checkLogin() async {
    final token = await storage.readToken();
    return token != null ? HomePage() : LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Login App',
      home: FutureBuilder<Widget>(
        future: checkLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data!;
          }
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
