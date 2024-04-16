import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/MyButton.dart';
import 'package:frontend/components/MyTextField.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forgot Password',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ForgotPasswordScreen(),
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final emailController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();
  // String _email = '';

  bool _isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    return regex.hasMatch(email);
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

Future<void> resetPassword() async {
  if (!_isEmailValid(emailController.text.trim())) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: Text('Please enter a valid email address.'),
        );
      },
    );
    return; // Stop further execution if the email is not valid
  }

  var currentContext = context;


  try {
    // Attempt to send a password reset email
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
    showDialog(
      context: currentContext,
      builder: (context) {
        return const AlertDialog(
          content: Text('A password reset link has been sent to your email.'),
        );
      },
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      showDialog(
        context: currentContext,
        builder: (context) {
          return const AlertDialog(
            content: Text('The entered email address is not registered.'),
          );
        },
      );
    } else {
      print(e);
      showDialog(
        context: currentContext,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
        backgroundColor: Colors.grey[700],
      ),
      body: Column(
        children: [
          const SizedBox(height: 50,),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child:  Text(
              'Enter Your Email and We Will SEND You A Password Reset Link',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),


          MyTextField(
            controller: emailController, 
            hintText: 'Email', 
            obscureText: false
          ),

          const SizedBox(height: 50,),

          MyButton(onTap: resetPassword, text: 'Reset Password')
            
        ]
      )
    );
  }
}