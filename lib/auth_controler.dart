import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_logic/home_screen.dart';
import "package:app_logic/login_screen.dart";
import 'package:firebase_auth/firebase_auth.dart';

class AuthControler extends StatelessWidget{
  const AuthControler({super.key});

  @override

  Widget build(BuildContext context){
    final firebaseUser = context.watch<User?>();

    if(firebaseUser != null){
      return const Homescreen();
    }else {
      return const LoginScreen();
    }
  }
}