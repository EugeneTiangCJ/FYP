import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/MyButton.dart';
import 'package:frontend/components/MyTextField.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Password',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: EditPasswordScreen(),
    );
  }
}

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  final userEmail = FirebaseAuth.instance.currentUser!.email!;

    @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  Future <void> changePassword() async{

    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   }
    // );
    var cred = EmailAuthProvider.credential(email: userEmail, password: oldPasswordController.text);
    try{
      if(confirmNewPasswordController.text == newPasswordController.text){
        await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(cred).then(
          (value) {
            FirebaseAuth.instance.currentUser!.updatePassword(newPasswordController.text);
          }
        );

        Navigator.pop(context);

        showMessage("Password Change");

      } else{

        Navigator.pop(context);

        showMessage("Confirm New Password doesn't MATCH with New Password");
      }
      
    } on FirebaseAuthException catch(e){
      
        Navigator.pop(context);

      showMessage(e.message.toString());
    }

  }

  void showMessage(String message){
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
        title: Text('Edit Password'),
        backgroundColor: Colors.grey[700],
      ),
      body: Column(
        children: [

          const SizedBox(height: 50),

          MyTextField(
            controller: oldPasswordController, 
            hintText: 'Old Password', 
            obscureText: true
          ),

          const SizedBox(height: 25),

          MyTextField(
            controller: newPasswordController, 
            hintText: 'New Password', 
            obscureText: true
          ),

          const SizedBox(height: 25),

          MyTextField(
            controller: confirmNewPasswordController, 
            hintText: 'Confirm Password', 
            obscureText: true
          ),

          const SizedBox(height: 50),

          MyButton(
            onTap: changePassword,
            text: 'Change Password'
          ),

          const SizedBox(height: 50),

          MyButton(
            onTap: (){
              Navigator.pushNamed(context, '/profile');
            }, 
            text: 'Change Password'
          ),

        ],
      )
    );
  }
}
