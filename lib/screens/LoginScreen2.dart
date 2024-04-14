// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:frontend/screens/ForgotPasswordScreen.dart';
// import 'package:frontend/screens/HomeScreen.dart';
// import 'package:frontend/screens/NewUserRegistrationScreen.dart';



// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Login Screen',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: LoginScreen(),
//     );
//   }
// }



// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});


//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
  
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   void signUserin() async {
//     await FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: emailController.text, 
//     password: passwordController.text,
//   );
// }

//   bool _isEmailValid(String email) {
//     Pattern pattern =
//         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//     RegExp regex = RegExp(pattern as String);
//     return regex.hasMatch(email);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('WELCOME'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextFormField(
//                 controller:emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty || !_isEmailValid(value)) {
//                     return 'Please enter a valid email address';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _email = value!,
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller:passwordController,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(),
//                 ),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _password = value!,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 child: Text('Log In'),
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Logging in...')),
//                     );
//                     _formKey.currentState!.save();
//                     // Here you can handle the login logic
//                   }
//                   // Navigator.pushNamed(context, '/home');
//                 },
//               ),
//               TextButton(
//                 child: Text('Sign Up'),
//                 onPressed: () {
//                   // Here you would navigate to the sign-up screen
//                   Navigator.pushNamed(context, '/register');
//                 },
//               ),
//               TextButton(
//                 child: Text('Forget Password?'),
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/forgotpassword');
//                 },
//                 style: TextButton.styleFrom(
//                   foregroundColor: Colors.black54, // Text color
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
