import 'package:flutter/material.dart';
// Import the sea_creature_details.dart page
import 'sea_creature_details.dart';

void main() {
  runApp(SustainableSeafoodApp());
}

class SustainableSeafoodApp extends StatelessWidget {
  const SustainableSeafoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SeafoodGuideScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SeafoodGuideScreen extends StatelessWidget {
  const SeafoodGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Sea Creatures'),
        backgroundColor: const Color.fromARGB(255, 192, 237, 255),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for Sea Creatures',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            // List of Sea Creatures with Vertical Scrolling
            Expanded(
              child: ListView(
                children: [
                  SeaCreatureCard(
                    imageUrl: 'assets/images/cuttlefish.png',
                    name: 'Broadclub Cuttlefish',
                    description:
                        'The broadclub cuttlefish is a predatory cephalopod (squid, octopus, or cuttlefish).',
                  ),
                  SeaCreatureCard(
                    imageUrl: 'assets/images/blenny.png',
                    name: 'Sailfin blenny',
                    description:
                        'This small fish has a long, scaleless body and a large, distinct dorsal fin.',
                  ),
                  // Seahorse card with navigation
                  SeaCreatureCard(
                    imageUrl: 'assets/images/seahorse.png',
                    name: 'Hippocampus',
                    description:
                        'The yellow seahorse is scientifically known as Hippocampus kuda.',
                    onTap: () {
                      // Navigate to sea_creature_details.dart only for this card
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeaCreatureDetailScreen(),
                        ),
                      );
                    },
                  ),
                  // Other cards without navigation or custom navigation
                  SeaCreatureCard(
                    imageUrl: 'assets/images/lobster.png',
                    name: 'Blue lobster',
                    description:
                        'Homarus gammarus, the European or common lobster, which is blue while alive.',
                  ),
                  SeaCreatureCard(
                    imageUrl: 'assets/images/grouper.png',
                    name: 'Nassau Grouper',
                    description:
                        'The Nassau grouper is one of the large number of perciform fishes in the family.',
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

class SeaCreatureCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final VoidCallback? onTap; // Nullable onTap for conditional navigation

  const SeaCreatureCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
    this.onTap, // onTap is optional
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        onTap: onTap, // Trigger navigation if onTap is provided
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              // Text Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Read more',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
