import 'package:flutter/material.dart';
import 'package:frontend/screens/AppScreen.dart';
import 'package:frontend/screens/EditPasswordScreen.dart';
import 'package:frontend/screens/FeedbackForm.dart';
import 'package:frontend/screens/ForgotPasswordScreen.dart';
import 'package:frontend/screens/GuidelinesScreen.dart';
import 'package:frontend/screens/HomeScreen.dart';
import 'package:frontend/screens/LoginScreen.dart';
import 'package:frontend/screens/NewUserRegistrationScreen.dart';
import 'package:frontend/screens/ProfileScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/screens/auth_page.dart';
import 'package:frontend/screens/face_record_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,)
  // .then(
    // (Firebase value) => Get.put(AuthenticationRepository()),)
    ;
   runApp( const MyApp());
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(primarySwatch: Colors.green),
      home: AuthPage(),
      routes:{
        '/login':(context) => LoginScreen(),
        '/forgotpassword': (context) => ForgotPasswordScreen(),
        '/register': (context) => NewUserRegistrationScreen(),
        '/home':(context) => HomeScreen(),
        '/profile': (context) => ProfileScreen() ,
        '/guidelines':(context) => GuidelinesScreen(),
        '/feedback':(context) => FeedbackForm(),
        '/editpassword':(context) => EditPasswordScreen(),
        '/installapp': (context) => InstalledAppsScreen(),
        // '/facerecord': (context) => FaceRecordScreen(),
      },
    );
  }
}