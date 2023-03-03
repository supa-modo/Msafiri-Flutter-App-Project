import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geolocator/geolocator.dart';

import '../../../size_config/size_config.dart';

class LocationSearch extends StatefulWidget {
  const LocationSearch({Key? key}) : super(key: key);

  @override
  _LocationSearchState createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  final TextEditingController _searchController = TextEditingController();
  late GoogleMapsPlaces _places;
  late List<Prediction> _autocompleteResults;
  Completer<GoogleMapController> _controller = Completer();
  late LatLng _currentLatLng;

  @override
  void initState() {
    super.initState();

    _places = GoogleMapsPlaces(apiKey: 'YOUR_API_KEY');

    _getCurrentLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    final Position position = await Geolocator.getCurrentPosition();
    _currentLatLng = LatLng(position.latitude, position.longitude);
  }

  Future<void> _onChanged(String value) async {
    final PlacesAutocompleteResponse response = await _places.autocomplete(
      value,
      location:
          Location(lat: _currentLatLng.latitude, lng: _currentLatLng.longitude),
      radius: 10000,
    );

    setState(() {
      _autocompleteResults = response.predictions;
    });
  }

  Future<void> _onLocationSelected(String description) async {
    final PlacesDetailsResponse details = await _places.getDetailsByPlaceId(
        (await _places.autocomplete(description,
                location: Location(
                    lat: _currentLatLng.latitude,
                    lng: _currentLatLng.longitude),
                radius: 10000))
            .predictions
            .first
            .placeId!);

    final LatLng latLng = LatLng(details.result.geometry!.location.lat,
        details.result.geometry!.location.lng);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(latLng));

    Navigator.of(context).pop(latLng);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: getScreenWidth(16),
            right: getScreenWidth(16),
            bottom: getScreenHeight(10),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _onChanged,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Search your destination location',
              hintStyle: TextStyle(fontSize: getScreenWidth(15)),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount:
                _autocompleteResults != null ? _autocompleteResults.length : 0,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_autocompleteResults[index].description!),
                onTap: () {
                  _onLocationSelected(_autocompleteResults[index].description!);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
