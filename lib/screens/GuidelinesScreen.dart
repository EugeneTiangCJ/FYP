import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  GuidelinesScreen({super.key});

  // List <String> docIDs = [];

  // Future getDocId() async {
  //   await FirebaseFirestore.instance.collection('guidelines').get().then(
  //     (snapshot) => snapshot.docs.forEach(
  //         (guide){
  //           print(guide.reference);
  //           docIDs.add(guide.reference.id);
  //       }
  //     )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Text('Guidelines'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.grey[300], // The color for the box
            height: 700,
            width: 400,
            // Use a Text widget to display read-only text.
            child: Text(
              'abc ', // Replace with your actual guidelines text
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
