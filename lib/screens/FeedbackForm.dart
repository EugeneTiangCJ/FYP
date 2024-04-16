import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/MyButton.dart';
import 'package:frontend/components/MyTextField.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback Form',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FeedbackForm(),
    );
  }
}

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final feedbackController = TextEditingController();


  void submitFeedback() async{
    try{
      await FirebaseFirestore.instance
      .collection("feedback")
      .add({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'feedback': feedbackController.text
      });

      // showDialog(
      //   context: context, 
      //   builder: (context) {
      //     return const AlertDialog(
      //       backgroundColor: Colors.deepPurple,
      //       title: Center(
      //         child: Text(
      //           'Submit Successfully!',
      //           style: TextStyle(color: Colors.white)
      //         ),
      //       ),
      //     );
      //   }
      // );
      
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/home'); // Navigate to HomeScreen
    } on FirebaseAuthException catch(e){
      showErrorMessage(e.message.toString());
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
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: Column(
        children: [
          MyTextField(
            controller: nameController, 
            hintText: 'Name', 
            obscureText: false),

          const SizedBox(height: 25,),

          MyTextField(
            controller: emailController, 
            hintText: 'Email', 
            obscureText: false),

          const SizedBox(height: 25,),
          
          MyTextField(
            controller: feedbackController, 
            hintText: 'Feedback', 
            obscureText: false),

          const SizedBox(height: 50,),

          MyButton(
            onTap: submitFeedback, 
            text: 'Submit'
          ),

          const SizedBox(height: 50,),

          MyButton(
            onTap: (){
              Navigator.pushNamed(context, '/home');
            }, 
            text: 'Cancel'
          )
        ],
      )
    );
  }
}
