import 'package:clean_seas_flutter/screens/seafoodGuide/endangered_species.dart';
import 'package:clean_seas_flutter/screens/seafoodGuide/seasonal_reccomendation.dart';
import 'package:flutter/material.dart';
import 'explore_sea_creatures.dart';
import 'good_for_consumption.dart';

void main() {
  runApp(SustainableSeafoodGuideApp());
}

class SustainableSeafoodGuideApp extends StatelessWidget {
  const SustainableSeafoodGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SustainableSeafoodGuideHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SustainableSeafoodGuideHome extends StatelessWidget {
  const SustainableSeafoodGuideHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sustainable Seafood Guide Home'),
        backgroundColor: const Color.fromARGB(255, 192, 237, 255),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for Sea Creatures',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Explore Sea Creatures Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Explore Sea Creatures',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      //navigation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SeafoodGuideScreen(),
                        ),
                      );
                    },
                    child: const Text('See all'),
                  ),
                ],
              ),
              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    SeaCreatureCard(
                        imageUrl: 'assets/images/starfish.png',
                        name: 'Star Fish'),
                    SeaCreatureCard(
                        imageUrl: 'assets/images/urchin.png',
                        name: 'The Sea Urchin'),
                    SeaCreatureCard(
                        imageUrl: 'assets/images/octopus.png',
                        name: 'Blue Ring Octopus'),
                    // Add more sea creatures as needed
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Endangered Species Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Endangered Species',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      //navigation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SeafoodGuideScreens(),
                        ),
                      );
                    },
                    child: const Text('See all'),
                  ),
                ],
              ),
              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    SeaCreatureCard(
                        imageUrl: 'assets/images/turtle.png',
                        name: 'Hawksbill Turtle'),
                    SeaCreatureCard(
                        imageUrl: 'assets/images/squid.png',
                        name: 'Hawaiin Squid'),
                    SeaCreatureCard(
                        imageUrl: 'assets/images/whale.png',
                        name: 'Whale Shark'),
                    // Add more endangered species as needed
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Updated Buttons for Recommendations and Sustainable Choices
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeasonalRecommendationScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Seasonal Recommendation',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Enjoy the best seafood options available throughout the year',
                            maxLines: 2,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConsumptionScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Make Sustainable Choices',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Find out which seafood is good for consumption and which should be avoided',
                            maxLines: 2,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios),
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

class SeaCreatureCard extends StatelessWidget {
  final String imageUrl;
  final String name;

  const SeaCreatureCard(
      {super.key, required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(imageUrl, fit: BoxFit.cover),
          ),
          const SizedBox(height: 5),
          Text(name, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
