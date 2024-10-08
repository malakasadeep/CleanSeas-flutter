import 'package:clean_seas_flutter/screens/seafoodGuide/explore_sea_creatures.dart';
import 'package:flutter/material.dart';

class SeaCreatureDetailScreen extends StatelessWidget {
  final SeaCreature seaCreature;
  const SeaCreatureDetailScreen({super.key, required this.seaCreature});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Sea Creature'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                // Image
                Image.asset(
                  seaCreature.imageUrl, // Replace with your image asset
                  height: 300,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                // Sea Creature Name Over Image
                Positioned(
                  bottom: 20,
                  left: 16,
                  child: Text(
                    seaCreature.name, // Sea creature name
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Roboto', // Change to a custom font if needed
                    ),
                  ),
                ),
                // Back Arrow
                Positioned(
                  top: 16,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            // Information and description section
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 230, 247, 255),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20), // Spacing below the image

                  // Scientific and classification details
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16), // Gray color for text
                      children: [
                        TextSpan(text: 'Scientific name: '),
                        TextSpan(
                          text: 'Hippocampus kuda\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        TextSpan(text: 'Class: '),
                        TextSpan(
                          text: 'Actinopterygii\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        TextSpan(text: 'Genus: '),
                        TextSpan(
                          text: 'Hippocampus\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        TextSpan(text: 'Phylum: '),
                        TextSpan(
                          text: 'Chordata\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        TextSpan(text: 'Domain: '),
                        TextSpan(
                          text: 'Eukaryota\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        TextSpan(text: 'Family: '),
                        TextSpan(
                          text: 'Syngnathidae\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        TextSpan(text: 'Kingdom: '),
                        TextSpan(
                          text: 'Animalia\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    seaCreature.longDescription,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
