import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/screens/EditPasswordScreen.dart';
import 'package:frontend/screens/FeedbackForm.dart';
import 'package:frontend/screens/ForgotPasswordScreen.dart';
import 'package:frontend/screens/GuidelinesScreen.dart';
import 'package:frontend/screens/HomeScreen.dart';
import 'package:frontend/screens/LoginScreen.dart';
import 'package:frontend/screens/NewUserRegistrationScreen.dart';
import 'package:frontend/screens/ProfileScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,)
  // .then(
  //   (Firebase value) => Get.put(AuthenticationRepository()),)
    ;
   runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(primarySwatch: Colors.green),
      home: LoginScreen(),
      routes:{
        '/login':(context) => LoginScreen(),
        '/forgotpassword': (context) => ForgotPasswordScreen(),
        '/register': (context) => NewUserRegistrationScreen(),
        '/home':(context) => HomeScreen(),
        '/profile': (context) => ProfileScreen() ,
        '/guidelines':(context) => GuidelinesScreen(),
        '/feedback':(context) => FeedbackForm(),
        '/editpassword':(context) => EditPasswordScreen(),
      },
    );
  }
}