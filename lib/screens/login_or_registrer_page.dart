// import 'package:flutter/cupertino.dart';
// import 'package:frontend/screens/LoginScreen.dart';
// import 'package:frontend/screens/NewUserRegistrationScreen.dart';

// class LoginOrRegisterPage extends StatefulWidget {
//   const LoginOrRegisterPage({super.key});

//   @override
//   State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
// }

// class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
//   bool showLoginPage = true;

//   void togglePages(){
//     setState(() {
//       showLoginPage = !showLoginPage;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     if (showLoginPage){
//       return LoginScreen(
//         onTap: togglePages,
//       );
//     }
//     else {
//       return NewUserRegistrationScreen(
//         onTap: togglePages,
//       );
//     }
//   }
// }