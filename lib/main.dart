import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iOS Device Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DeviceInfoScreen(),
    );
  }
}

class DeviceInfoScreen extends StatefulWidget {
  @override
  _DeviceInfoScreenState createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  String _deviceInfo = 'Loading...';

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  Future<void> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceDetails = '';

    try {
      // Fetching iOS device info
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceDetails = 'Device: ${iosInfo.utsname.machine}\n'
          'OS Version: ${iosInfo.systemVersion}\n'
          'Model: ${iosInfo.model}\n'
          'Name: ${iosInfo.name}';
    } catch (e) {
      deviceDetails = 'Failed to get device info: $e';
    }

    setState(() {
      _deviceInfo = deviceDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iOS Device Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            _deviceInfo,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
