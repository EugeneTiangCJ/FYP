import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/MyButton.dart';
import 'package:frontend/components/MyTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      );
    
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, password: passwordController.text
     );

      Navigator.pop(context);

    } on FirebaseAuthException catch(e) {

      Navigator.pop(context);

      showErrorMessage(e.code);
      
    }

  }

  void showErrorMessage(String message){
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white)
            ),
          ),
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height:50),
            
                const Icon(
                  Icons.lock,
                  size:100,
                  ),
            
                  const SizedBox(height:50),
            
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    )
                  ),
            
                  const SizedBox(height:25),
            
                  //email
                  MyTextField(
                    controller: emailController, 
                    hintText: 'Email', 
                    obscureText: false
                  ),
                  
                  const SizedBox(height:25),
                  
                  //password
                  MyTextField(
                    controller: passwordController, 
                    hintText: 'Password', 
                    obscureText: true
                  ),
            
                  const SizedBox(height:10),
            
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/forgotpassword');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'ForgotPassword?',
                            style: TextStyle(color: Colors.grey[600])
                          ),
                        ],
                      )
                    ),
                  ),
            
                  const SizedBox(height:25),
            
                  MyButton(
                    onTap: signUserIn,
                    text: 'Sign In',
                  ),
                  
                  const SizedBox(height:50),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a Member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text(
                          'Register Now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]
                  )
            
                  
              ],
                  ),
          ),
        )
      )
    );
  }
}