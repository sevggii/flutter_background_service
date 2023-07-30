import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Fetch App',
      home: LocationScreen(),
    );
  }
}

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? latitude;
  String? longitude;

  @override
  void initState() {
    super.initState();
    checkAndRequestLocationPermission();
  }

  Future<bool> _checkLocationPermission() async {
    final permissionStatus = await Permission.location.request();
    return permissionStatus.isGranted;
  }

  Future<void> checkAndRequestLocationPermission() async {
    if (await _checkLocationPermission()) {
      fetchLocation();
    }
  }

  Future<void> fetchLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: Duration(seconds: 10),
    );

    setState(() {
      if (position.latitude == 0.0 && position.longitude == 0.0) {
        latitude = 'Location unavailable';
        longitude = 'Location unavailable';
      } else {
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
      }
      print(latitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Fetch App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Latitude: $latitude',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Longitude: $longitude',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          checkAndRequestLocationPermission();
        },
        child: Icon(Icons.location_on),
      ),
    );
  }
}
