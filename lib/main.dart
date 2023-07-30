import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'controllers/main_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MainController _mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Location Fetch App',
      home: LocationScreen(),
    );
  }
}

class LocationScreen extends StatelessWidget {
  final MainController _mainController = Get.find();

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
            Obx(() => Text(
                  'Latitude: ${_mainController.latitude.value}',
                  style: TextStyle(fontSize: 20),
                )),
            SizedBox(height: 10),
            Obx(() => Text(
                  'Longitude: ${_mainController.longitude.value}',
                  style: TextStyle(fontSize: 20),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mainController.fetchLocation();
        },
        child: Icon(Icons.location_on),
      ),
    );
  }
}
