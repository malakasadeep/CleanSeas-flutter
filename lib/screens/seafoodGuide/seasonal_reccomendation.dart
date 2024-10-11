import 'package:clean_seas_flutter/screens/seafoodGuide/seafood_guide_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(SeasonalRecommendationScreen());
}

class SeasonalRecommendationScreen extends StatelessWidget {
  const SeasonalRecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFEAF6FD), // Light blue background
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text(
            'Seasonal Recommendation',
            style: TextStyle(color: Colors.grey[300]),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey[300]), // Back arrow
                    onPressed: () {
                      //navigation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SustainableSeafoodGuideHome(),
                        ),
                      );
                    },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchBar(),
                const SizedBox(height: 16),
                const Legend(),
                const SizedBox(height: 16),
                Expanded(child: SeaCreatureGrid()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          hintText: "Search for Sea Creatures",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}

class Legend extends StatelessWidget {
  const Legend({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        LegendItem(color: Colors.indigo, label: "Abundant & best value"),
        SizedBox(height: 8), // Add some spacing between items
        LegendItem(color: Colors.blue, label: "Should be available"),
        SizedBox(height: 8), // Add some spacing between items
        LegendItem(
            color: Color.fromARGB(255, 122, 196, 231), label: "Out of season"),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 16, height: 16, color: color),
        SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

// Data class for Sea Creatures
class SeaCreature {
  final String name;
  final String zone;
  final String image;
  final String availability;
  final List<int> seasonMonths; // List of months when the creature is in season
  final List<int> activeHours; // List of hours when the creature is active

  SeaCreature({
    required this.name,
    required this.zone,
    required this.image,
    required this.availability,
    required this.seasonMonths,
    required this.activeHours,
  });
}

class SeaCreatureGrid extends StatelessWidget {
  SeaCreatureGrid({super.key});

  // Current date and time
  final DateTime now = DateTime.now();

  // List of sea creatures
  final List<SeaCreature> creatures = [
    SeaCreature(
      name: "Broadclub Cuttlefish",
      zone: "North-West Coast",
      image: "assets/images/cuttlefish.png",
      availability: "indigo",
      seasonMonths: [6, 7, 8], // June to August
      activeHours: [6, 7, 8, 9, 10, 11], // 6 AM to 11 AM
    ),
    SeaCreature(
      name: "Oyster",
      zone: "South-East Coast",
      image: "assets/images/oyster.png",
      availability: "blue",
      seasonMonths: [3, 4, 5], // March to May
      activeHours: [12, 13, 14, 15, 16], // 12 PM to 4 PM
    ),
    SeaCreature(
      name: "Blue Crab",
      zone: "North-West Coast",
      image: "assets/images/blue_crab.png",
      availability: "indigo",
      seasonMonths: [6, 7, 8], // June to August
      activeHours: [6, 7, 8, 9, 10, 11], // 6 AM to 11 AM
    ),
    SeaCreature(
      name: "Blue Crab",
      zone: "North-West Coast",
      image: "assets/images/blue_crab.png",
      availability: "indigo",
      seasonMonths: [9, 10, 11], //  September to November
      activeHours: [13,14,15,16,17], // 1 PM to 5 PM
    ),
    SeaCreature(
      name: "Red Snapper",
      zone: "South-West Coast",
      image: "assets/images/red_snapper.png",
      availability: "indigo",
      seasonMonths: [9, 10, 11], // September to November
      activeHours: [17, 18, 19, 20], // 5 PM to 8 PM
    ),
    SeaCreature(
      name: "Jack Mackerel",
      zone: "North-West Coast",
      image: "assets/images/jack_mackerel.png",
      availability: "indigo",
      seasonMonths: [6, 7, 8], // June to August
      activeHours: [6, 7, 8, 9, 10, 11], // 6 AM to 11 AM
    ),
    SeaCreature(
      name: "Jack Mackerel",
      zone: "North-West Coast",
      image: "assets/images/jack_mackerel.png",
      availability: "lightBlue",
      seasonMonths: [9, 10, 11], // September to November
      activeHours: [13,14,15,16,17], // 5 PM to 8 PM
    ),
    SeaCreature(
      name: "Lobster",
      zone: "South-West Coast",
      image: "assets/images/lobster2.png",
      availability: "blue",
      seasonMonths: [9, 10, 11], // September to November
      activeHours: [13,14,15,16,17], // 5 PM to 8 PM
    ),
    SeaCreature(
      name: "Trout",
      zone: "South-West Coast",
      image: "assets/images/trout.png",
      availability: "blue",
      seasonMonths: [9, 10, 11], // September to November
      activeHours: [13,14,15,16,17], // 5 PM to 8 PM
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Filter creatures based on current month and hour
    List<SeaCreature> filteredCreatures = creatures.where((creature) {
      return creature.seasonMonths.contains(now.month) &&
          creature.activeHours.contains(now.hour);
    }).toList();

    // Display a message if no creatures are available
    if (filteredCreatures.isEmpty) {
      return Center(
        child: Text(
          "No sea creatures are recommended at this time.",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }

    return GridView(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75, // Adjust aspect ratio as needed
      ),
      children: filteredCreatures.map((creature) {
        return SeaCreatureCard(creature: creature);
      }).toList(),
    );
  }
}

class SeaCreatureCard extends StatelessWidget {
  final SeaCreature creature;

  const SeaCreatureCard({super.key, required this.creature});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image of the sea creature
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              creature.image,
              fit: BoxFit.cover,
              height: 100,
              width: double.infinity,
            ),
          ),
          // Details of the sea creature
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  creature.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "Zone: ${creature.zone}",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text("Availability:", style: TextStyle(fontSize: 12)),
                    Spacer(),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _getColor(creature.availability),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(String availability) {
    switch (availability) {
      case 'indigo':
        return Colors.indigo;
      case 'blue':
        return Colors.blue;
      case 'lightBlue':
        return const Color.fromARGB(255, 142, 212, 244);
      default:
        return Colors.grey;
    }
  }
}
