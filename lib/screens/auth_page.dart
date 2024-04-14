import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/screens/HomeScreen.dart';
import 'package:frontend/screens/LoginScreen.dart';
import 'package:frontend/screens/login_or_registrer_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream:FirebaseAuth.instance.authStateChanges(),  
        builder: ((context, snapshot) {
          if (snapshot.hasData){
            return const HomeScreen();
          }

          else{
            return const LoginScreen();
          }
        }),
      )
    );
  }
}