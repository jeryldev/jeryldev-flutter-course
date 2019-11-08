import 'dart:async';

import 'package:google_map_demo/src/models/user_location_model.dart';
import 'package:location/location.dart';

class LocationService {
  UserLocationModel _currentLocation;
  var location = Location();

  Future<UserLocationModel> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocationModel(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
    return _currentLocation;
  }

  StreamController<UserLocationModel> _locationController =
      StreamController<UserLocationModel>();

  Stream<UserLocationModel> get locationStream => _locationController.stream;

  LocationService() {
    // Request permission to use location
    location.requestPermission().then(
      (granted) {
        if (granted) {
          // If granted listen to the onLocationChanged stream and emit over our controller
          location.onLocationChanged().listen(
            (locationData) {
              if (locationData != null) {
                _locationController.add(
                  UserLocationModel(
                    latitude: locationData.latitude,
                    longitude: locationData.longitude,
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
