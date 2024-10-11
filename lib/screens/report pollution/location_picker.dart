import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:location/location.dart' as loc;

class LocationPicker extends StatefulWidget {
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  GoogleMapController? _controller;
  LatLng? _currentPosition;
  TextEditingController _searchController = TextEditingController();
  bool isMapReady = false; // Ensure map is ready before interacting

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    loc.Location location = loc.Location();
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    var userLocation = await location.getLocation();

    setState(() {
      _currentPosition =
          LatLng(userLocation.latitude!, userLocation.longitude!);
    });
  }

  Future<void> _moveToLocation(LatLng position) async {
    if (isMapReady && _controller != null) {
      print("Animating camera to position: $position");
      await _controller!.animateCamera(CameraUpdate.newLatLng(position));
      setState(() {
        _currentPosition = position;
      });
    } else {
      print("GoogleMapController is not initialized or map is not ready yet");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundBlue,
        title: Text(
          'Pick a location',
          style: GoogleFonts.raleway(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Iconsax.arrow_circle_left, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          _currentPosition == null
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _currentPosition!, zoom: 14),
                  onMapCreated: (controller) {
                    _controller = controller;
                    isMapReady = true; // Mark the map as ready
                    print("GoogleMapController created"); // Debug print
                  },
                  onTap: (position) {
                    _moveToLocation(position);
                  },
                  markers: {
                    if (_currentPosition != null)
                      Marker(
                        markerId: MarkerId('selected_location'),
                        position: _currentPosition!,
                      ),
                  },
                ),
          Positioned(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: GooglePlaceAutoCompleteTextField(
                    textEditingController: _searchController,
                    googleAPIKey:
                        "AIzaSyAPcKOA3rdm5EO1cFlnHvI-yEJRepMzF30", // Replace with your API Key
                    inputDecoration: InputDecoration(
                      hintText: 'Enter location',
                      prefixIcon: Icon(Icons.search, color: Colors.blue),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            // Hide suggestions
                          });
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14.0),
                    ),
                    debounceTime: 800,
                    countries: ["LK"], // Limit to Sri Lanka
                    isLatLngRequired: true,
                    getPlaceDetailWithLatLng: (Prediction prediction) async {
                      if (prediction.lat != null && prediction.lng != null) {
                        LatLng latLng = LatLng(double.parse(prediction.lat!),
                            double.parse(prediction.lng!));
                        print("Selected location: $latLng"); // Debug print
                        await _moveToLocation(latLng);
                      } else {
                        print(
                            "Invalid LatLng data: ${prediction.lat}, ${prediction.lng}");
                      }
                    },
                    itemClick: (Prediction prediction) {
                      _searchController.text = prediction.description!;
                      setState(() {
                        // Hide suggestions
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment(0.75, 0.99),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context, _currentPosition);
          },
          backgroundColor: Colors.white,
          child: const Icon(Iconsax.location_add, color: Colors.black),
        ),
      ),
    );
  }
}
