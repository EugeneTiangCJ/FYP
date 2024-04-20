import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: InstalledAppsScreen(),
    );
  }
}

class InstalledAppsScreen extends StatefulWidget {
  const InstalledAppsScreen({super.key});

  @override
  _InstalledAppsScreenState createState() => _InstalledAppsScreenState();
}

class _InstalledAppsScreenState extends State<InstalledAppsScreen> {
  List<Application> apps = [];
  Map<String, bool> appLockStates = {};

  @override
  void initState() {
    super.initState();
    _getApps();
  }

  void _getApps() async {
    List<Application> _apps = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );
    Map<String, bool> _appLockStates = Map.fromIterable(
      _apps,
      key: (app) => app.packageName,
      value: (app) => false, // Default value is set to false for all apps
    );
    setState(() {
      apps = _apps;
      appLockStates = _appLockStates;
    });
  }

  void _toggleAppLock(String packageName) {
    setState(() {
      appLockStates[packageName] = !appLockStates[packageName]!;
    });
    // Here you would also handle the actual app locking logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Installed Apps'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _getApps,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: apps.length,
        itemBuilder: (context, index) {
          Application app = apps[index];
          bool isLocked = appLockStates[app.packageName] ?? false;
          return ListTile(
            leading: app is ApplicationWithIcon ? Image.memory(app.icon) : null,
            title: Text(app.appName),
            subtitle: Text('Version: ${app.versionName}'),
            trailing: Switch(
              value: isLocked,
              onChanged: (bool value) {
                _toggleAppLock(app.packageName);
              },
            ),
          );
        },
      ),
    );
  }
}
