import 'package:flutter/material.dart';
import 'features/auth/login_screen.dart';
import 'services/keep_alive_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Keep Alive Service ko start karna
  KeepAliveService().startKeepAlive();

  runApp(const RabbitApp());
}

class RabbitApp extends StatelessWidget {
  const RabbitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rabbit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.amber,
          surface: Colors.black,
        ),
      ),
      // App sabse pehle Login Screen par open hoga
      home: const LoginScreen(),
    );
  }
}
