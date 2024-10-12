import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:clean_seas_flutter/screens/seafoodGuide/endangered_species.dart';
import 'package:clean_seas_flutter/screens/seafoodGuide/explore_sea_creatures.dart';
import 'package:clean_seas_flutter/screens/seafoodGuide/good_for_consumption.dart';
import 'package:clean_seas_flutter/screens/seafoodGuide/seasonal_reccomendation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SustainableSeafoodGuideHome extends StatelessWidget {
  const SustainableSeafoodGuideHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            automaticallyImplyLeading: false, // This removes the back button
            backgroundColor: backgroundBlue,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Sustainable Seafood Guide',
                    style: TextStyle(color: Colors.white, shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                      ),
                    ])),
              ),
              background: Image.asset(
                'assets/images/seabg.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimationLimiter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                    children: [
                      _buildSearchBar(),
                      SizedBox(height: 20),
                      _buildSectionTitle('Explore Sea Creatures', () {
                        // Navigate to SeafoodGuideScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SeafoodGuideScreens(),
                          ),
                        );
                      }),
                      _buildHorizontalList(
                        [
                          SeaCreatureCard(
                              imageUrl: 'assets/images/starfish.png',
                              name: 'Star Fish'),
                          SeaCreatureCard(
                              imageUrl: 'assets/images/manta_ray.png',
                              name: 'Manta Ray'),
                          SeaCreatureCard(
                              imageUrl: 'assets/images/octopus.png',
                              name: 'Blue Ring Octopus'),
                        ],
                      ),
                      SizedBox(height: 20),
                      _buildSectionTitle('Endangered Species', () {
                        // Navigate to SeafoodGuideScreens
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const EndangeredSeaCreaturesScreen(),
                          ),
                        );
                      }),
                      _buildHorizontalList(
                        [
                          SeaCreatureCard(
                              imageUrl: 'assets/images/turtle.png',
                              name: 'Hawksbill Turtle'),
                          SeaCreatureCard(
                              imageUrl: 'assets/images/squid.png',
                              name: 'Hawaiin Squid'),
                          SeaCreatureCard(
                              imageUrl: 'assets/images/whale.png',
                              name: 'Whale Shark'),
                        ],
                      ),
                      SizedBox(height: 20),
                      _buildActionButton(
                        'Seasonal Recommendation',
                        'Enjoy the best seafood options available throughout the year',
                        Icons.calendar_today,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SeasonalRecommendationScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      _buildActionButton(
                        'Make Sustainable Choices',
                        'Find out which seafood is good for consumption and which should be avoided',
                        Icons.eco,
                        () {
                          // Navigate to ConsumptionScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ConsumptionScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for Sea Creatures',
        prefixIcon: Icon(Icons.search, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildSectionTitle(String title, VoidCallback onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextButton(
          onPressed: onPressed,
          child: Text('See all', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  Widget _buildHorizontalList(List<Widget> children) {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: children,
      ),
    );
  }

  Widget _buildActionButton(
      String title, String subtitle, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16.0),
        backgroundColor: Colors.blue.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 40),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.blue),
        ],
      ),
    );
  }
}

class SeaCreatureCard extends StatelessWidget {
  final String imageUrl;
  final String name;

  const SeaCreatureCard({Key? key, required this.imageUrl, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
