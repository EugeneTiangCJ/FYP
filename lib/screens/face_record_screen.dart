import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class FaceRecordScreen extends StatefulWidget {
  final List<CameraDescription> cameras; // 将相机列表作为参数传递进来
  const FaceRecordScreen({super.key, required this.cameras});

  @override
  _FaceRecordScreenState createState() => _FaceRecordScreenState();
}

class _FaceRecordScreenState extends State<FaceRecordScreen> {
  late CameraController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    // 使用第一个可用的摄像头（这里假设是前置摄像头，可以根据实际情况调整）
    _controller = CameraController(widget.cameras[1], ResolutionPreset.medium);
    await _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> captureAndSendImage() async {
    if (!_controller.value.isInitialized) {
      print('Camera is not initialized');
      return;
    }
    try {
      XFile file = await _controller.takePicture();
      Uint8List imageBytes = await file.readAsBytes();

      String url = 'http://192.168.1.10:5000/capture';
      var response = await http.post(Uri.parse(url),
          body: imageBytes,
          headers: {'Content-Type': 'application/octet-stream'});
      print('Server responded with status: ${response.statusCode}');

      Navigator.pop(context);

      showDialog(
        context: context, 
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(
                'Image Captured Successfully!',
                style: TextStyle(color: Colors.white)
              ),
            ),
          );
        }
      );

      // Navigator.pushNamed(context, '/home'); 
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Face Record'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: _isInitialized ? CameraPreview(_controller) : const Center(child: CircularProgressIndicator()),
            ),
            FloatingActionButton(
              onPressed: captureAndSendImage,
              child: const Icon(Icons.camera),
            )
          ],
        ),
      ),
    );
  }
}
