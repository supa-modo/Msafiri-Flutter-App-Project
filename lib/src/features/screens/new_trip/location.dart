import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

class LocationProvider with ChangeNotifier {
  DetailsResult? _destination;
  double? _destinationLatitude;
  double? _destinationLongitude;

  DetailsResult? get destination => _destination;

  set destination(DetailsResult? value) {
    _destination = value;
    _destinationLatitude = _destination!.geometry!.location!.lat!;
    _destinationLongitude = _destination!.geometry!.location!.lng!;
    notifyListeners();
  }

  double? get destinationLatitude => _destinationLatitude;

  double? get destinationLongitude => _destinationLongitude;
  LatLng getDestinationLatLng() {
    if (_destinationLatitude == null || _destinationLongitude == null) {
      return LatLng(0, 0);
    } else {
      return LatLng(_destinationLatitude!, _destinationLongitude!);
    }
  }
}
