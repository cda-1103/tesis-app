import 'package:app_logic/Authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  String _message = '';
  bool _isloading = false;
  bool _isSuccess = false;


  Future<void> _sendResteEmail() async {
    if (_emailController.text.isEmpty){
      setState(() {
        _message = 'Por favor, ingresa tu correo electrónico.';
        _isSuccess = false;
      });
      return;
    }

    setState(() {
      _isloading = true;
      _message= '';
    });

    final authService = context.read<AuthenticationService>();
    final result = await authService.sendPasswordResetEmail(
      _emailController.text.trim(),
    );

    if (!mounted) return;

    if (result == 'success'){
      setState(() {
        _isloading = false;
        _isSuccess = true;
        _message = '¡Correo enviado! Revisa tu bandeja de entrada (y spam) para restablecer tu contraseña';
      });
    }else {
      setState(() {
        _isloading = false;
        _isSuccess = false;
        _message = result;
      });
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restablecer Contraseña'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Recibe un correo',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              const Text(
                'Ingresa el correo electrónico asociado a tu cuenta.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30),
              if (_message.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    _message,
                    // Mostramos el mensaje en verde si es éxito, o rojo si es error
                    style: TextStyle(
                      color: _isSuccess ? Colors.green.shade400 : Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // Deshabilitamos el botón mientras carga
                  onPressed: _isloading ? null : _sendResteEmail,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isloading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text('Enviar Correo'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}