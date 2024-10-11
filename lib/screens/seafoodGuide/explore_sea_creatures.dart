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

// Sea creature model class
class SeaCreature {
  final String id;
  final String name;
  final String description;
  final String longDescription;
  final String imageUrl;

  SeaCreature({
    required this.id,
    required this.name,
    required this.description,
    required this.longDescription,
    required this.imageUrl,
  });
}

// Sample list of sea creatures
final List<SeaCreature> seaCreatures = [
  SeaCreature(
    id: '1',
    name: 'Broadclub Cuttlefish',
    description:
        'The broadclub cuttlefish is a predatory cephalopod (squid, octopus, or cuttlefish).',
    longDescription:
        'The Broadclub Cuttlefish is one of the largest and most fascinating species of cuttlefish, known for its remarkable ability to change color and texture to blend into its surroundings. This cephalopod species, native to the warm waters of the Indo-Pacific region, is a master of camouflage. It can manipulate its skin pigmentation in an instant, not only to hide from predators but also to communicate with other cuttlefish and to stun prey with pulsating patterns of color',
    imageUrl: 'assets/images/cuttlefish.png',
  ),
  SeaCreature(
    id: '2',
    name: 'Sailfin blenny',
    description:
        'This small fish has a long, scaleless body and a large, distinct dorsal fin.',
    longDescription:
        'The Sailfin Blenny is a small but eye-catching species of blenny that inhabits shallow coral reefs and rocky shorelines throughout the Western Atlantic, from the Caribbean to the Gulf of Mexico. Despite their diminutive size, usually growing no more than 5 centimeters in length, Sailfin Blennies are well-known for their bold and striking dorsal fin, which resembles a sail and can be raised dramatically to attract mates or deter rivals',
    imageUrl: 'assets/images/blenny.png',
  ),
  SeaCreature(
    id: '3',
    name: 'Hippocampus',
    description:
        'The yellow seahorse is scientifically known as Hippocampus kuda.',
    longDescription:
        'Seahorses, Hippocampus, are small marine fish that are found in shallow tropical and temperate waters around the world. They are known for their horse-like head and their prehensile tail, which they use to anchor themselves to coral or seaweed. Seahorses have a unique appearance and are among the most distinctive fish in the ocean.',
    imageUrl: 'assets/images/seahorse.png',
  ),
  SeaCreature(
    id: '4',
    name: 'Blue lobster',
    description:
        'Homarus gammarus, the European or common lobster, which is blue while alive.',
    longDescription:
        'The Blue Lobster, scientifically known as Homarus gammarus, is an extraordinary variant of the European lobster and is famous for its striking cobalt-blue coloration, which is a rare genetic mutation found in about 1 in 2 million lobsters. Typically, lobsters are brownish-green or reddish-brown, camouflaging well with the seabed. However, the blue lobster’s vibrant hue is the result of an overproduction of a particular protein, creating an eye-catching appearance',
    imageUrl: 'assets/images/lobster.png',
  ),
  SeaCreature(
    id: '5',
    name: 'Nassau Grouper',
    description:
        'The Nassau grouper is one of the large number of perciform fishes in the family.',
    longDescription:
        'The Nassau grouper has a robust, elongated body covered in vertical, dark stripes or bars that become more pronounced when the fish is excited or stressed. Its color can range from pale cream to brownish-red, depending on its surroundings and behavior, making it an expert at blending in with coral reefs, rocky outcrops, and seagrass beds. They can grow up to 1.2 meters (4 feet) in length and weigh as much as 25 kilograms (55 pounds)',
    imageUrl: 'assets/images/grouper.png',
  ),
];

class SeafoodGuideScreen extends StatefulWidget {
  const SeafoodGuideScreen({super.key});

  @override
  _SeafoodGuideScreenState createState() => _SeafoodGuideScreenState();
}

class _SeafoodGuideScreenState extends State<SeafoodGuideScreen> {
  // List to hold favorite sea creatures
  List<String> favorites = [];

  // Controller to track the text in the search field
  TextEditingController searchController = TextEditingController();

  // List to hold the filtered sea creatures
  List<SeaCreature> filteredSeaCreatures = seaCreatures;

  @override
  void initState() {
    super.initState();
    searchController
        .addListener(_filterSeaCreatures); // Add listener to the search field
  }

  // Function to handle search filtering
  void _filterSeaCreatures() {
    String query = searchController.text.toLowerCase();

    setState(() {
      filteredSeaCreatures = seaCreatures
          .where(
              (seaCreature) => seaCreature.name.toLowerCase().contains(query))
          .toList();
    });
  }

  // Function to handle toggling favorites
  void toggleFavorite(String seaCreatureName) {
    setState(() {
      if (favorites.contains(seaCreatureName)) {
        favorites.remove(seaCreatureName); // Remove from favorites
      } else {
        favorites.add(seaCreatureName); // Add to favorites
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose(); // Clean up the controller
    super.dispose();
  }

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
              controller: searchController,
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
              child: filteredSeaCreatures.isNotEmpty
                  ? ListView(
                      children: filteredSeaCreatures.map((seaCreature) {
                        return SeaCreatureCard(
                          imageUrl: seaCreature.imageUrl,
                          name: seaCreature.name,
                          description: seaCreature.description,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeaCreatureDetailScreen(
                                  seaCreature: seaCreature,
                                ),
                              ),
                            );
                          }, // Only navigate on the Seahorse card
                          isFavorite: favorites.contains(seaCreature.name),
                          onFavoriteToggle: () =>
                              toggleFavorite(seaCreature.name),
                        );
                      }).toList(),
                    )
                  : Center(
                      child: Text(
                        'No sea creatures found.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
  final bool isFavorite; // Indicates if the creature is favorited
  final VoidCallback? onFavoriteToggle; // Handles toggling favorites

  const SeaCreatureCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
    this.onTap,
    required this.isFavorite, // Required to handle favorite state
    this.onFavoriteToggle,
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
              // Favorite Icon
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: onFavoriteToggle, // Toggle favorite on press
              ),
            ],
          ),
        ),
      ),
    );
  }
}
