import 'package:flutter/material.dart';

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
        title: Text('Sustainable Seafood Guide Home'),
        backgroundColor: const Color.fromARGB(255, 192, 237, 255),
        elevation: 0,
      ),
      body: Padding(
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
            SizedBox(height: 20),

            // Explore Sea Creatures Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Explore Sea Creatures',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: Text('See all'),
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
            SizedBox(height: 20),

            // Endangered Species Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Endangered Species',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: Text('See all'),
                ),
              ],
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  SeaCreatureCard(
                      imageUrl: 'assets/turtle.png', name: 'Hawksbill Turtle'),
                  SeaCreatureCard(
                      imageUrl: 'assets/squid.png', name: 'Hawaiin Squid'),
                  SeaCreatureCard(
                      imageUrl: 'assets/whale.png', name: 'Whale Shark'),
                  // Add more endangered species as needed
                ],
              ),
            ),
            SizedBox(height: 20),

            // Buttons for Recommendations and Sustainable Choices
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey[300]),
              child: Text('Seasonal Recommendation'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey[300]),
              child: Text('Make Sustainable Choices'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.delete), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: ''),
        ],
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
      margin: EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(imageUrl, fit: BoxFit.cover),
          ),
          SizedBox(height: 5),
          Text(name, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
