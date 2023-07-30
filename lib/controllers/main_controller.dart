import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class MainController extends GetxController {
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (position.latitude == 0.0 && position.longitude == 0.0) {
        latitude.value = 'Location unavailable';
        longitude.value = 'Location unavailable';
      } else {
        latitude.value = position.latitude.toString();
        longitude.value = position.longitude.toString();
      }
      print(latitude.value);
    } catch (e) {
      print('Failed to fetch location: $e');
    }
  }
}
