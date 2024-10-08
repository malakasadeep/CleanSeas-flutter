import 'package:flutter/material.dart';

void main() {
  runApp(SeasonalRecommendationApp());
}

class SeasonalRecommendationApp extends StatelessWidget {
  const SeasonalRecommendationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SeasonalRecommendationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SeasonalRecommendationScreen extends StatefulWidget {
  const SeasonalRecommendationScreen({super.key});

  @override
  _SeasonalRecommendationScreenState createState() =>
      _SeasonalRecommendationScreenState();
}

class _SeasonalRecommendationScreenState
    extends State<SeasonalRecommendationScreen> {
  // Colors used to represent availability
  final Color abundantColor = Colors.blue;
  final Color moderateColor = Colors.lightBlue;
  final Color scarceColor = Colors.grey;

  // Selected filters for availability
  bool showAbundant = true;
  bool showModerate = true;
  bool showScarce = true;

  // List of sea creatures
  final List<SeaCreature> seaCreatures = [
    SeaCreature(
      name: 'Cuttlefish',
      season: 'Summer (Jun-Aug)',
      zone: 'North-West Coast',
      availabilityColor: Colors.blue,
    ),
    SeaCreature(
      name: 'Oyster',
      season: 'Spring (Mar-May)',
      zone: 'South-East Coast',
      availabilityColor: Colors.lightBlue,
    ),
    SeaCreature(
      name: 'Blue crab',
      season: 'Summer (Jun-Aug)',
      zone: 'North-West Coast',
      availabilityColor: Colors.blue,
    ),
    SeaCreature(
      name: 'Red Snapper',
      season: 'Autumn (Sep-Nov)',
      zone: 'South-West Coast',
      availabilityColor: Colors.grey,
    ),
    SeaCreature(
      name: 'Jack Mackerel',
      season: 'Summer (Jun-Aug)',
      zone: 'North-West Coast',
      availabilityColor: Colors.blue,
    ),
    SeaCreature(
      name: 'Prawns',
      season: 'Spring (Mar-May)',
      zone: 'North-West Coast',
      availabilityColor: Colors.blue,
    ),
    // Add more sea creatures if necessary
  ];

  // Method to filter sea creatures based on availability
  List<SeaCreature> getFilteredCreatures() {
    return seaCreatures.where((creature) {
      if (creature.availabilityColor == abundantColor && showAbundant) {
        return true;
      } else if (creature.availabilityColor == moderateColor && showModerate) {
        return true;
      } else if (creature.availabilityColor == scarceColor && showScarce) {
        return true;
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seasonal Recommendation'),
        backgroundColor: const Color.fromARGB(255, 192, 237, 255),
        elevation: 0,
      ),
      body: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: 10),
              // Availability Filters
              Row(
                children: [
                  Checkbox(
                    value: showAbundant,
                    onChanged: (bool? value) {
                      setState(() {
                        showAbundant = value ?? false;
                      });
                    },
                  ),
                  Text('Abundant & best value'),
                  SizedBox(width: 10),
                  Container(
                    width: 15,
                    height: 15,
                    color: abundantColor,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: showModerate,
                    onChanged: (bool? value) {
                      setState(() {
                        showModerate = value ?? false;
                      });
                    },
                  ),
                  Text('Should be available'),
                  SizedBox(width: 10),
                  Container(
                    width: 15,
                    height: 15,
                    color: moderateColor,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: showScarce,
                    onChanged: (bool? value) {
                      setState(() {
                        showScarce = value ?? false;
                      });
                    },
                  ),
                  Text('Out of season'),
                  SizedBox(width: 10),
                  Container(
                    width: 15,
                    height: 15,
                    color: scarceColor,
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Display filtered sea creatures
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true, // Ensure GridView doesn't take infinite space
                physics: NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                children: getFilteredCreatures()
                    .map((creature) => SeaCreatureCard(creature: creature))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Sea Creature Model
class SeaCreature {
  final String name;
  final String season;
  final String zone;
  final Color availabilityColor;

  SeaCreature({
    required this.name,
    required this.season,
    required this.zone,
    required this.availabilityColor,
  });
}

// Sea Creature Card Widget
class SeaCreatureCard extends StatelessWidget {
  final SeaCreature creature;

  const SeaCreatureCard({super.key, required this.creature});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/${creature.name.toLowerCase().replaceAll(' ', '_')}.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              creature.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Season: ${creature.season}'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Fishing Zone: ${creature.zone}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Availability:'),
                SizedBox(width: 5),
                Container(
                  width: 15,
                  height: 15,
                  color: creature.availabilityColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}