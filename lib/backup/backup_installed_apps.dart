import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../screens/auth_service.dart';
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
      checkMatch().then((matchResult) {
        if (matchResult) {
          DeviceApps.openApp(app.packageName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Authentication failed, retry!'))
          );
        }
      });
    } else {
      DeviceApps.openApp(app.packageName);
    }
  }

  Future<bool> checkMatch() async {
    var uri = Uri.parse('http://192.168.1.10:5000/compare');
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      bool match = data['Match'];
      return match;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
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
