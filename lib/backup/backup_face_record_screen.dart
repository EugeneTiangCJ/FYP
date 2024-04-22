import 'package:flutter/material.dart';
import 'package:frontend/components/MyButton.dart';
import 'package:http/http.dart' as http;

class FaceRecordScreen extends StatefulWidget {
  const FaceRecordScreen({super.key});

  @override
  _FaceRecordScreenState createState() => _FaceRecordScreenState();
}

class _FaceRecordScreenState extends State<FaceRecordScreen> {
  
void captureAndProcessImage() async {
  var response = await http.get(
    Uri.parse('http://192.168.1.10:5000/capture'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response == true){
    
  }
  if (response.statusCode == 200) {
    print('Success: ${response.body}');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Done record!'))
    );
  } else {
    print('Failed with error code: ${response.statusCode}');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('404 Fail to record!'))
    );    
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Record')
      ),
      backgroundColor: Colors.grey[300],
        body:  Center(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                MyButton(
                  onTap: captureAndProcessImage,
                  text: 'Face Record',
                ),

                const SizedBox(height: 50),
            ]
          ),

        ),   
    );
  }
}