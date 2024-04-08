import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guidelines',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: GuidelinesScreen(),
    );
  }
}

class GuidelinesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guidelines'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.white, // The color for the box
            // Use a Text widget to display read-only text.
            child: Text(
              'Your guidelines text goes here...', // Replace with your actual guidelines text
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
