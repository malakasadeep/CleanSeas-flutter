import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Firebase storage
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore
import 'package:clean_seas_flutter/constants/colours.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to manage input
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();
  File? _eventImage; // Variable to hold the image file
  LatLng? _eventLocation; // Variable to hold the selected event location
  bool _isLoading = false; // To track loading state

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDateController.dispose();
    _eventDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026, 11, 9),
    );

    if (pickedDate != null) {
      setState(() {
        _eventDateController.text =
            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      });
    }
  }

  Future<void> _selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _eventImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectLocation(BuildContext context) async {
    final LatLng? selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LocationPickerScreen(),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        _eventLocation = selectedLocation;
      });
    }
  }

  Future<String?> _uploadImageToFirebase(File imageFile) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef =
          FirebaseStorage.instance.ref().child('event_images/$fileName');
      await storageRef.putFile(imageFile);
      return await storageRef.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _submitEvent() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      // Upload the image to Firebase Storage if selected
      String? imageUrl;
      if (_eventImage != null) {
        imageUrl = await _uploadImageToFirebase(_eventImage!);
      }

      // Create a new event object with Firestore
      final newEvent = {
        'title': _eventNameController.text,
        'description': _eventDescriptionController.text,
        'image': imageUrl ?? 'default_image_url',
        'date': _eventDateController.text,
        'location': _eventLocation != null
            ? GeoPoint(_eventLocation!.latitude, _eventLocation!.longitude)
            : null,
        'created_at': FieldValue.serverTimestamp(),
      };

      // Save the event to Firestore
      await FirebaseFirestore.instance.collection('events').add(newEvent);

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event Created Successfully')),
      );

      // Clear form
      _eventNameController.clear();
      _eventDateController.clear();
      _eventDescriptionController.clear();
      setState(() {
        _eventImage = null;
        _eventLocation = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.white,
                    child: const Icon(Iconsax.arrow_circle_left,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Schedule Cleaning Event',
                  style: GoogleFonts.raleway(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _eventNameController,
                        decoration: InputDecoration(
                          labelText: 'Event Name',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the event name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _eventDateController,
                        decoration: InputDecoration(
                          labelText: 'Event Date',
                          suffixIcon: IconButton(
                            icon: const Icon(Iconsax.calendar,
                                color: Colors.black),
                            onPressed: () => _selectDate(context),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select the event date';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _eventDescriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Event Description',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the event description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _selectImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Upload Event Image',
                          style: GoogleFonts.raleway(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (_eventImage != null)
                        Image.file(
                          _eventImage!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _selectLocation(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Select Event Location',
                          style: GoogleFonts.raleway(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (_eventLocation != null)
                        Text(
                          'Location: ${_eventLocation!.latitude}, ${_eventLocation!.longitude}',
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitEvent,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                'Submit Event',
                                style: GoogleFonts.raleway(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Screen to pick a location using Google Maps
class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({Key? key}) : super(key: key);

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  GoogleMapController? _controller;
  LatLng _pickedLocation = const LatLng(37.7749, -122.4194); // Default to SF
  Location location = Location();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    LocationData userLocation = await location.getLocation();
    setState(() {
      _pickedLocation = LatLng(userLocation.latitude ?? 37.7749,
          userLocation.longitude ?? -122.4194);
    });
  }

  void _selectLocation(LatLng latLng) {
    setState(() {
      _pickedLocation = latLng;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Event Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pickedLocation,
          zoom: 14.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        onTap: _selectLocation,
        markers: {
          Marker(
            markerId: const MarkerId('pickedLocation'),
            position: _pickedLocation,
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          Navigator.pop(context, _pickedLocation);
        },
      ),
    );
  }
}
