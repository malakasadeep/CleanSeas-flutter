import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
// Import the sea_creature_details.dart page
import 'sea_creature_details.dart';

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

class SeafoodGuideScreens extends StatefulWidget {
  const SeafoodGuideScreens({Key? key}) : super(key: key);

  @override
  _SeafoodGuideScreensState createState() => _SeafoodGuideScreensState();
}

class _SeafoodGuideScreensState extends State<SeafoodGuideScreens>
    with SingleTickerProviderStateMixin {
  List<String> favorites = [];
  TextEditingController searchController = TextEditingController();
  List<SeaCreature> filteredSeaCreatures = seaCreatures;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterSeaCreatures);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  void _filterSeaCreatures() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredSeaCreatures = seaCreatures
          .where(
              (seaCreature) => seaCreature.name.toLowerCase().contains(query))
          .toList();
    });
  }

  void toggleFavorite(String seaCreatureName) {
    setState(() {
      if (favorites.contains(seaCreatureName)) {
        favorites.remove(seaCreatureName);
      } else {
        favorites.add(seaCreatureName);
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context); // Back navigation
                  },
                  backgroundColor: Colors.white,
                  mini: true, // Make the button smaller
                  child: const Icon(Iconsax.arrow_circle_left,
                      color: Colors.black),
                ),
              ),
              SizedBox(width: 10), // Add some space between the button and text
              Expanded(
                // Wrap the text in Expanded to prevent overflow
                child: Text(
                  'Sea Creatures',
                  style: TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis, // Handle long text
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.white),
              onPressed: () {
                // TODO: Implement favorites screen
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(color: backgroundBlue),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, 50 * (1 - _animation.value)),
                        child: Opacity(
                          opacity: _animation.value,
                          child: child,
                        ),
                      );
                    },
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for Sea Creatures',
                        prefixIcon:
                            Icon(Icons.search, color: Colors.blue.shade900),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: filteredSeaCreatures.isNotEmpty
                        ? ListView.builder(
                            itemCount: filteredSeaCreatures.length,
                            itemBuilder: (context, index) {
                              final seaCreature = filteredSeaCreatures[index];
                              return AnimatedBuilder(
                                animation: _animation,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset:
                                        Offset(0, 50 * (1 - _animation.value)),
                                    child: Opacity(
                                      opacity: _animation.value,
                                      child: child,
                                    ),
                                  );
                                },
                                child: SeaCreatureCard(
                                  imageUrl: seaCreature.imageUrl,
                                  name: seaCreature.name,
                                  description: seaCreature.description,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SeaCreatureDetailScreen(
                                                seaCreature: seaCreature),
                                      ),
                                    );
                                  },
                                  isFavorite:
                                      favorites.contains(seaCreature.name),
                                  onFavoriteToggle: () =>
                                      toggleFavorite(seaCreature.name),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              'No sea creatures found.',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SeaCreatureCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const SeaCreatureCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.description,
    this.onTap,
    required this.isFavorite,
    this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.blue.shade100],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'seaCreature_${name}',
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Read more',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: onFavoriteToggle,
                          ),
                        ],
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
