import 'dart:convert';
import 'package:http_parser/http_parser.dart'; // For MediaType
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class FaceRecognitionScreen extends StatefulWidget {
  @override
  _FaceRecognitionScreenState createState() => _FaceRecognitionScreenState();
}

class _FaceRecognitionScreenState extends State<FaceRecognitionScreen> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[1], ResolutionPreset.medium);
    await _controller.initialize();
    setState(() {
      _isReady = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

Future<bool> _sendPictureForRecognition() async {
  XFile file = await _controller.takePicture();
  var uri = Uri.parse('http://192.168.1.10:5000/compare');
  
  // Create a multipart request
  var request = http.MultipartRequest('POST', uri)
    ..files.add(await http.MultipartFile.fromPath(
      'image', 
      file.path,
      contentType: MediaType('image', 'jpg')
    ));
  
  // Send the request
  var response = await request.send();

  if (response.statusCode == 200) {
    // Listen for response
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    return json.decode(result)['Match'];
  }
  return false;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Recognition'),
      ),
      body: _isReady
          ? Column(
              children: [
                Expanded(child: CameraPreview(_controller)),
                ElevatedButton(
                  child: const Text('Authenticate'),
                  onPressed: () async {
                    bool result = await _sendPictureForRecognition();
                    Navigator.pop(context, result);
                  },
                )
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
