import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart' show GoogleMapsPlaces;
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final String apiKey = "AIzaSyAb37oGF7BebVQlkRe3q2Z0tCIW3QJl8j8";
  List<LatLng> polygonVertices = [];
  Set<Marker> _markers = {};
  Set<Polygon> _polygons = {};
  bool _isDrawingMode = false;
  bool _showNDVIButton = false;
  int _polygonIdCounter = 1;
  LatLng _currentPosition = LatLng(20.5937, 78.9629);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      return;
    }

    // Check for permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permission denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print(
        "Location permission permanently denied. Please enable it in settings.",
      );
      return;
    }

    // Fetch the current location if permission is granted
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        if (mapController != null) {
          mapController!.animateCamera(
            CameraUpdate.newLatLng(_currentPosition),
          );
        }
        _markers.add(
          Marker(
            markerId: MarkerId('current_location'),
            position: _currentPosition,
            infoWindow: InfoWindow(title: 'Your Location'),
          ),
        );
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController!.animateCamera(CameraUpdate.newLatLng(_currentPosition));
  }

  void _onMapTap(LatLng latLng) {
    if (_isDrawingMode) {
      setState(() {
        polygonVertices.add(latLng);
        _addDraggableMarker(latLng);
        _addPolygon();
        if (polygonVertices.length >= 4) {
          _showNDVIButton = true;
        }
      });
    }
  }

  void _addDraggableMarker(LatLng latLng) {
    final markerId = MarkerId('marker_${_polygonIdCounter++}');
    _markers.add(
      Marker(
        markerId: markerId,
        position: latLng,
        draggable: true,
        onDragEnd: (newPosition) {
          setState(() {
            polygonVertices[polygonVertices.indexOf(latLng)] = newPosition;
            _addPolygon();
          });
        },
      ),
    );
  }

  void _addPolygon() {
    final polygonId = PolygonId('polygon_$_polygonIdCounter');
    _polygons.add(
      Polygon(
        polygonId: polygonId,
        points: polygonVertices,
        strokeColor: Colors.blue,
        fillColor: Colors.blue.withOpacity(0.2),
        strokeWidth: 2,
      ),
    );
  }

  void _toggleDrawingMode() {
    setState(() {
      _isDrawingMode = !_isDrawingMode;
      if (!_isDrawingMode) {
        polygonVertices.clear();
        _polygons.clear();
        _markers.clear();
        _polygonIdCounter++;
        _showNDVIButton = false;
        _markers.add(
          Marker(
            markerId: MarkerId('current_location'),
            position: _currentPosition,
            infoWindow: InfoWindow(title: 'Your Location'),
          ),
        );
      }
    });
  }

  void _fetchNDVIAndWeatherData() {
    // _fetchNDVIImage();
    _fetchWeatherData();
  }

  // void _fetchNDVIImage() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text("NDVI Image"),
  //         content: Text(
  //           "Fetched NDVI image for polygon with vertices: $polygonVertices",
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text("Close"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<void> _fetchWeatherData() async {
    if (polygonVertices.length < 3) {
      print("Not enough vertices to form a polygon.");
      return;
    }

    final coordinates = [
      ...polygonVertices
          .map((vertex) => [vertex.longitude, vertex.latitude])
          .toList(),
      [polygonVertices.first.longitude, polygonVertices.first.latitude],
    ];

    final geoJson = {
      "geometry": {
        "type": "Polygon",
        "coordinates": [coordinates],
      },
    };

    const apiKey =
        'apk.ec441022ff2069467253ef6116de69a400841a416e5c4d2bf7c7c6ab88e7835b';
    final url = Uri.parse(
      'https://api-connect.eos.com/api/forecast/weather/forecast/?api_key=$apiKey',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(geoJson),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print("Response Data: $data");

        if (data.isNotEmpty) {
          final firstEntry = data[0];
          double maxTemp = (firstEntry['Temp_air_max'] ?? 0.0).toDouble();
          double minTemp = (firstEntry['Temp_air_min'] ?? 0.0).toDouble();
          double humidity = (firstEntry['Rel_humidity'] ?? 0.0).toDouble();
          String date =
              DateTime.now().toString().split(' ')[0]; // Get only date

          _showWeatherDialog(maxTemp, minTemp, humidity, date);
        } else {
          print("No weather data available.");
          _showWeatherDialog(null, null, null, null);
        }
      } else {
        print("Failed to fetch weather data: ${response.statusCode}");
        print("Response: ${response.body}");
      }
    } catch (e) {
      print("Error fetching weather data: $e");
    }
  }

  void _showWeatherDialog(
    double? maxTemp,
    double? minTemp,
    double? humidity,
    String? date,
  ) {
    String formattedDate =
        date ?? DateFormat('dd/MM/yyyy').format(DateTime.now());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Weather Forecast Date: $formattedDate",
            style: TextStyle(color: Colors.blue),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Max Temperature: ${maxTemp ?? 'N/A'}°C",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                "Min Temperature: ${minTemp ?? 'N/A'}°C",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                "Humidity: ${humidity ?? 'N/A'}%",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close", style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
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

      mapController.animateCamera(CameraUpdate.newLatLngZoom(newLocation, 15));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Analyse Farm'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(_isDrawingMode ? Icons.cancel : Icons.edit),
      //       onPressed: _toggleDrawingMode,
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.hybrid,
              onMapCreated: _onMapCreated,
              onTap: _onMapTap,
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 15,
              ),
              markers: _markers,
              polygons: _polygons,
            ),
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
                child: Row(
                  children: [
                    Expanded(
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
                    IconButton(
                      icon: Icon(_isDrawingMode ? Icons.cancel : Icons.edit),
                      onPressed: _toggleDrawingMode,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton:
          _showNDVIButton
              ? Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16, right: 45),
                child: FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: _fetchNDVIAndWeatherData,
                  child: Icon(Icons.cloud, color: Colors.white),
                ),
              )
              : Align(
                alignment: Alignment.bottomRight, // Move FAB to the left
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    bottom: 16,
                    right: 45,
                  ), // Adjust position
                  child: FloatingActionButton(
                    onPressed: _getCurrentLocation,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.my_location, color: Colors.white),
                  ),
                ),
              ),
    );
  }
}
