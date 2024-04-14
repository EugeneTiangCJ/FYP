import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ImageProvider _profileImage = AssetImage('assets/default_avatar.png');

  final user = FirebaseAuth.instance.currentUser!;

  Future<void> _changeProfilePicture() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = FileImage(File(image.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          const SizedBox(height: 20),

          GestureDetector(
            onTap: _changeProfilePicture,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: _profileImage,
            ),
          ),

          const SizedBox(height: 50),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Email: ${user.email!}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
            ],
          ), 
        
          const SizedBox(height: 70),
          
          ElevatedButton(
            onPressed: () {
              // Navigate to edit password page
              Navigator.pushNamed(context, '/editpassword');
            },
            child: const Text('Edit Password'),
          ),
        ],
      ),
    );
  }
}
