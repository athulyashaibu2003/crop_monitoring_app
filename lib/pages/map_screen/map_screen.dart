import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  LatLng _currentPosition = LatLng(
    20.5937,
    78.9629,
  ); // Default location (India)
  LatLng? _gpsPosition; // Store actual GPS location
  final String apiKey =
      "AIzaSyAb37oGF7BebVQlkRe3q2Z0tCIW3QJl8j8"; // Replace with your API key

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permissions are denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied.");
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _gpsPosition = _currentPosition; // Save actual GPS location
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition, 15),
      );
    });
  }

  void _moveToSelectedPlace(String placeId) async {
    final places = GoogleMapsPlaces(apiKey: apiKey);
    final detail = await places.getDetailsByPlaceId(placeId);

    if (detail.status == "OK") {
      final location = detail.result.geometry!.location;
      LatLng newLocation = LatLng(location.lat, location.lng);

      setState(() {
        _currentPosition = newLocation;
      });

      _mapController.animateCamera(CameraUpdate.newLatLngZoom(newLocation, 15));
    }
  }

  void _goToCurrentLocation() {
    if (_gpsPosition != null) {
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_gpsPosition!, 15),
      );
    } else {
      print("GPS location not available");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 5,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false, // Hide default button
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            ),

            // Search Bar
            Positioned(
              top: 10,
              left: 15,
              right: 15,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                ),
                child: GooglePlaceAutoCompleteTextField(
                  textEditingController: TextEditingController(),
                  googleAPIKey: apiKey,
                  inputDecoration: InputDecoration(
                    hintText: "Search Place...",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                    prefixIcon: Icon(Icons.search),
                  ),
                  debounceTime: 800,
                  isLatLngRequired: false,
                  getPlaceDetailWithLatLng: (placeId) {
                    _moveToSelectedPlace(placeId.toString());
                  },
                  itemClick: (prediction) {
                    _moveToSelectedPlace(prediction.placeId!);
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button to go back to current location
      floatingActionButton: Align(
        alignment: Alignment.bottomRight, // Move FAB to the left
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            bottom: 16,
            right: 45,
          ), // Adjust position
          child: FloatingActionButton(
            onPressed: _goToCurrentLocation,
            backgroundColor: Colors.blue,
            child: Icon(Icons.my_location, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
