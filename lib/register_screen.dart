
import 'package:app_logic/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override  
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordVerificationController = TextEditingController();
  DateTime? _selectedDate;
  String _errorMessage = '';
  bool _passwordVisible = true;
  
  
  void _signUp() async{
    final authenticationService = context.read<AuthenticationService>();

      if (_selectedDate == null){
        setState(() {
          _errorMessage = 'Por favor, selecciona tu fecha de nacimiento.';
        });
        return;
      }

      if (_passwordController.text != _passwordVerificationController.text){
        setState(() {
          _errorMessage = 'Las contraseñas no coinciden.';
        });
        return;
      }

      if (_nameController.text.isEmpty || _lastnameController.text.isEmpty || _usernameController.text.isEmpty || _emailController.text.isEmpty ){
        setState(() {
          _errorMessage = 'Todos los campos son obligatorios';
        });
        return;

      }
      setState(() {

        _errorMessage = '';
      });




    final user = await authenticationService.registerWithEmail(
      _emailController.text.trim(), 
      _passwordController.text.trim(), 
      _nameController.text.trim(), 
      _lastnameController.text.trim(), 
      _usernameController.text.trim(), 
      _selectedDate!,
      );

      if (user != null){
        if (mounted) Navigator.of(context).pop();
      }else {
        setState(() {
          _errorMessage = 'Error al registrar. Intentalo de nuevo';
        });
      }
  }


  Future<void>_selectedDat(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (datePicked !=null && datePicked != _selectedDate){
      setState(() {
        _selectedDate = datePicked;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cuenta'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                      ? 'Fecha de Nacimiento'
                      : 'Fecha de Nacimiento: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectedDat(context),
                ),
              ],
            ),

            const SizedBox(height: 40),  //meter aqui los diferentes campos del registro
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo Electronico',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 40),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.people),
              ),
              keyboardType: TextInputType.name,
            ),

            const SizedBox(height: 40),
            TextField(
              controller: _lastnameController,
              decoration: const InputDecoration(
                labelText: 'Apellido',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.people),
              ),
              keyboardType: TextInputType.name,
            ),
            
            const SizedBox(height: 40),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Nombre de Usuario',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.people),
              ),
              keyboardType: TextInputType.name,
            ),

            const SizedBox(height: 40),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: _passwordVisible,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.password),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: (){
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              ),
            ),     

            const SizedBox(height: 40),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: _passwordVisible,
              controller: _passwordVerificationController,
              decoration: InputDecoration(
                labelText: 'Verifica Tu Contraseña',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.password),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: (){
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              ),
            ),                   









            const SizedBox(height: 30),

            if (_errorMessage.isNotEmpty)
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
                onPressed: _signUp,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Registrase'),
              ),
            )
          ],
        ),
      ),
    );
  }



}

