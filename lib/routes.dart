import 'package:flutter/material.dart';

// Importa todas las pantallas que usarás en las rutas
import 'package:app_logic/login_screen.dart';
import 'package:app_logic/register_screen.dart';
import 'package:app_logic/forgot_password.dart';
import 'package:app_logic/home_screen.dart'; // Asumiendo que también quieres una ruta para /home

// Define un mapa global de rutas
// (Usando tus nombres de archivo)
final Map<String, WidgetBuilder> appRoutes = {
  // NOTA: No necesitamos '/login' aquí si AuthControler es el home.
  // Pero es bueno tenerlas por si acaso.
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/forgot-password': (context) => const ForgotPasswordScreen(),
  '/home': (context) => const Homescreen(),
};