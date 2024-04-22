import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:device_apps/device_apps.dart';
import 'package:frontend/screens/face_recognition_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InstalledAppsScreen extends StatefulWidget {
  const InstalledAppsScreen({super.key});

  @override
  _InstalledAppsScreenState createState() => _InstalledAppsScreenState();
}

class _InstalledAppsScreenState extends State<InstalledAppsScreen> {
  List<Application> apps = [];
  Map<String, bool> switchStates = {};
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _getApps();
    _loadSwitchStates();
  }

  Future<void> _getApps() async {
    List<Application> _apps = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );
    setState(() {
      apps = _apps;
    });
  }

  Future<void> _saveSwitchStates() async {
    await prefs.setString('switchStates', json.encode(switchStates));
  }

  Future<void> _loadSwitchStates() async {
    prefs = await SharedPreferences.getInstance();
    var storedStates = prefs.getString('switchStates');
    if (storedStates != null) {
      setState(() {
        switchStates = Map<String, bool>.from(json.decode(storedStates));
      });
    }
  }

  Future<void> toggleSwitch(String appId, bool value) async {
    setState(() {
      switchStates[appId] = value;
      _saveSwitchStates();
    });
  }

  Future<void> launchApp(Application app) async {
    bool shouldAuthenticate = switchStates[app.packageName] ?? false;

    if (shouldAuthenticate) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FaceRecognitionScreen()),
      );

      if (result) {
        DeviceApps.openApp(app.packageName);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Authentication Failed'),
              content: const Text('Please retry.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Retry'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      DeviceApps.openApp(app.packageName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Installed Apps'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _getApps,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: apps.length,
        itemBuilder: (context, index) {
          Application app = apps[index];
          return ListTile(
            onTap: () => launchApp(app),
            leading: app is ApplicationWithIcon ? Image.memory(app.icon) : null,
            title: Text(app.appName),
            subtitle: Text('Version: ${app.versionName}'),
            trailing: Switch(
              value: switchStates[app.packageName] ?? false,
              onChanged: (bool value) {
                toggleSwitch(app.packageName, value);
              },
            ),
          );
        },
      ),
    );
  }
}
