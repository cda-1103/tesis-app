
import 'package:app_logic/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatelessWidget {
  const Homescreen ({super.key});

  @override 
  Widget build(BuildContext context) {
    final authenticationService = context.read<AuthenticationService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Principal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: (){
              authenticationService.signOut();
            },
          )
        ],
      ),
      body: const Center(
        child: Text('estas Logueado'),
      ),
    );
  }
}