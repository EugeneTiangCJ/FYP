import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/MyButton.dart';
import 'package:frontend/components/MyTextField.dart';

class NewUserRegistrationScreen extends StatefulWidget {

  const NewUserRegistrationScreen({super.key});

  @override
  State<NewUserRegistrationScreen> createState() => _NewUserRegistrationScreenState();
}

class _NewUserRegistrationScreenState extends State<NewUserRegistrationScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      );
    
    try{
      if(passwordController.text == confirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text
        );

        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/home'); // Navigate to HomeScreen

      } else {
        Navigator.pop(context);
        showErrorMessage("Password don't match!");
      }
      

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

                  const SizedBox(height:25),

                  //confirm password
                  MyTextField(
                    controller: confirmPasswordController, 
                    hintText: 'Confirm Password', 
                    obscureText: true
                  ),            
                  const SizedBox(height:10),
            
                  const SizedBox(height:25),
            
                  MyButton(
                    onTap: signUserUp,
                    text: 'Sign Up',
                  ),
                  
                  const SizedBox(height:50),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have a account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/login');
                      },
                        child: const Text(
                          'Login Now',
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