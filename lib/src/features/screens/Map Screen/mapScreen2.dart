import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:project_x/src/constants/constants.dart';
import 'package:provider/provider.dart';

import '../new_trip/location.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;
  LocationData? _locationData;

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    final location = Location();
    try {
      final locationData = await location.getLocation();
      setState(() {
        _locationData = locationData;
      });
    } catch (e) {
      print('Could not get location: ${e.toString()}');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    locationProvider.addListener(() {
      _getPolyline();
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    LatLng destination = LatLng(locationProvider.destinationLatitude ?? 0,
        locationProvider.destinationLongitude ?? 0);

    return SafeArea(
      child: Scaffold(
        body: _locationData != null
            ? GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      _locationData!.latitude!, _locationData!.longitude!),
                  zoom: 14.4746,
                ),
                onMapCreated: onMapCreated,
                buildingsEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: {
                  Marker(
                    markerId: const MarkerId("Current Location"),
                    position: LatLng(
                        _locationData!.latitude!, _locationData!.longitude!),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed,
                    ),
                  ),
                  if (locationProvider.destination != null)
                    Marker(
                      markerId: const MarkerId("Destination Location"),
                      position: destination,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue,
                      ),
                    ),
                },
                polylines: Set<Polyline>.of(polylines.values),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _getPolyline();
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: appPrimaryColor,
        width: 5,
        points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    if (_locationData == null) return;

    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    if (locationProvider.destination == null) return;
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(_locationData!.latitude!, _locationData!.longitude!),
      PointLatLng(locationProvider.destinationLatitude!,
          locationProvider.destinationLongitude!),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      //clearing the previous polyline coordinates list
      polylineCoordinates.clear();

      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      //clearing the previous polyline from the map
      polylines.clear();

      //add the updated polyline to the map
      _addPolyLine();
    }
  }
}
