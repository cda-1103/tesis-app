import 'package:app_logic/authentication_service.dart';
import 'package:app_logic/forgot_password.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override 
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage ='';

  void _signIn() async{
    final authService = context.read<AuthenticationService>();
    final user = await authService.signInWithEmail(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (user == null){
      setState(() {
        _errorMessage = 'Error al iniciar sesion. Verifica tus credenciales';
      });
    }
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LogicAPP',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigoAccent,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo Electronico',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30),
              if(_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _signIn,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Iniciar Sesion'),
                ),
              ),
              const SizedBox(height: 10),


              const SizedBox(height: 20),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pushNamed('/forgot-password');
                },
                child: const Text('¿Olvidaste tu contraseña?'),
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pushNamed('/register');
                },
                child: const Text('¿No tienes cuenta? Regístrate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}