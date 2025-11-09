import 'package:app_logic/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_logic/auth_controler.dart';
import 'package:app_logic/authentication_service.dart';
import 'package:app_logic/login_screen.dart';
import 'package:app_logic/forgot_password.dart';
import 'package:app_logic/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(),
        ),
        StreamProvider<User?>(
          create: (context) => 
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        home: const AuthControler(),
        debugShowCheckedModeBanner: false,
        // Define todas tus rutas aquí
        routes: {
          '/login': (context) => LoginScreen(),
          '/forgot-password': (context) => ForgotPasswordScreen(),
          '/register': (context) => RegisterScreen(),
        },
      ),
    );
  }
}