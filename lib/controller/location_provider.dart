import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wether_app/services/location_services.dart';

class LocationProvider extends ChangeNotifier {
  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;

  final LocationServices _locationservices=LocationServices();

  Placemark? _currentLocationName;
  Placemark? get currentLocationname=>_currentLocationName; 

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location service is not enabled, prompt the user to enable it
      print("Location service is not enabled.");
      // Open location settings
      await Geolocator.openLocationSettings();
      _currentPosition = null;
      notifyListeners();
      return;
    }

    // Check location permission
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Request location permission
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // Location permission is denied
        print("Location permission is denied.");
        _currentPosition = null;
        notifyListeners();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Location permission is permanently denied
      print("Location permission is permanently denied.");
      _currentPosition = null;
      notifyListeners();
      return;
    }

    try {
    
      _currentPosition = await Geolocator.getCurrentPosition();
      // print("Current position: $_currentPosition");
      _currentLocationName=await _locationservices.getLocationName(_currentPosition);
      print(_currentLocationName);
      notifyListeners();
    } catch (e) {
     
      // print("Error getting current position: $e");
      _currentPosition = null;
      notifyListeners();
    }
  }
}
