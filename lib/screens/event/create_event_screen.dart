import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to manage input
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventLocationController =
      TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free up resources when not needed
    _eventNameController.dispose();
    _eventLocationController.dispose();
    _eventDateController.dispose();
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
                      Navigator.pop(context); // Back navigation
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
                      // Event Name Input Field
                      TextFormField(
                        controller: _eventNameController,
                        decoration: InputDecoration(
                          labelText: 'Event Name',
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0)),
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

                      // Event Location Input Field
                      TextFormField(
                        controller: _eventLocationController,
                        decoration: InputDecoration(
                          labelText: 'Event Location',
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the event location';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Event Date Input Field with Calendar Picker
                      TextFormField(
                        controller: _eventDateController,
                        decoration: InputDecoration(
                          labelText: 'Event Date',
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            icon: const Icon(Iconsax.calendar,
                                color: Colors.black),
                            onPressed: () => _selectDate(context),
                          ),
                        ),
                        readOnly: true, // Prevent manual input
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select the event date';
                          }
                          return null;
                        },
                        onTap: () =>
                            _selectDate(context), // Trigger date picker
                      ),
                      const SizedBox(height: 30),

                      TextFormField(
                        controller: _eventNameController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Event Description',
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0)),
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
                      const SizedBox(height: 30),
                      // Submit Button
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, proceed with submission
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Event Created')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Shedule Event',
                          style: GoogleFonts.raleway(
                            color: Colors.black,
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
