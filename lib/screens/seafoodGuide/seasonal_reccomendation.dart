import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SeasonalRecommendationScreen extends StatelessWidget {
  const SeasonalRecommendationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.blue[700],
        scaffoldBackgroundColor: Colors.blue[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[700],
          elevation: 0,
        ),
        fontFamily: 'Roboto',
      ),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Seasonal Seafood',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/seabg.jpg',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.blue.withOpacity(0.7)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchBar(),
                    SizedBox(height: 16),
                    Legend(),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SeaCreatureGrid(),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.blue[700]),
          suffixIcon: Icon(Icons.mic, color: Colors.blue[700]),
          hintText: "Search for Sea Creatures",
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}

class Legend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Availability Guide',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[700]),
        ),
        SizedBox(height: 8),
        LegendItem(
            color: Colors.green,
            label: "Abundant & best value",
            icon: Icons.thumb_up),
        LegendItem(
            color: Colors.orange, label: "Available", icon: Icons.access_time),
        LegendItem(
            color: Colors.red,
            label: "Out of season",
            icon: Icons.not_interested),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;

  const LegendItem(
      {Key? key, required this.color, required this.label, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: 8),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.black87)),
        ],
      ),
    );
  }
}

class SeaCreature {
  final String name;
  final String zone;
  final String image;
  final String availability;
  final List<int> seasonMonths;
  final List<int> activeHours;

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
      activeHours: [13, 14, 15, 16, 17], // 1 PM to 5 PM
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
      activeHours: [13, 14, 15, 16, 17], // 5 PM to 8 PM
    ),
    SeaCreature(
      name: "Lobster",
      zone: "South-West Coast",
      image: "assets/images/lobster2.png",
      availability: "blue",
      seasonMonths: [9, 10, 11], // September to November
      activeHours: [13, 14, 15, 16, 17], // 5 PM to 8 PM
    ),
    SeaCreature(
      name: "Trout",
      zone: "South-West Coast",
      image: "assets/images/trout.png",
      availability: "blue",
      seasonMonths: [9, 10, 11], // September to November
      activeHours: [13, 14, 15, 16, 17], // 5 PM to 8 PM
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    List<SeaCreature> filteredCreatures = creatures.where((creature) {
      return creature.seasonMonths.contains(now.month) &&
          creature.activeHours.contains(now.hour);
    }).toList();

    if (filteredCreatures.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Text(
            "No sea creatures are recommended at this time.",
            style: TextStyle(fontSize: 16, color: Colors.blue[700]),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return SliverAnimatedGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      initialItemCount: filteredCreatures.length,
      itemBuilder: (context, index, animation) {
        return AnimationConfiguration.staggeredGrid(
          position: index,
          duration: const Duration(milliseconds: 375),
          columnCount: 2,
          child: ScaleAnimation(
            child: FadeInAnimation(
              child: SeaCreatureCard(creature: filteredCreatures[index]),
            ),
          ),
        );
      },
    );
  }
}

class SeaCreatureCard extends StatelessWidget {
  final SeaCreature creature;

  const SeaCreatureCard({Key? key, required this.creature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              creature.image,
              fit: BoxFit.cover,
              height: 120,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  creature.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  "Zone: ${creature.zone}",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(_getAvailabilityIcon(creature.availability),
                        color: _getColor(creature.availability), size: 20),
                    SizedBox(width: 4),
                    Text(_getAvailabilityText(creature.availability),
                        style: TextStyle(
                            fontSize: 14,
                            color: _getColor(creature.availability))),
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
        return Colors.green;
      case 'blue':
        return Colors.orange;
      case 'lightBlue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getAvailabilityIcon(String availability) {
    switch (availability) {
      case 'indigo':
        return Icons.thumb_up;
      case 'blue':
        return Icons.access_time;
      case 'lightBlue':
        return Icons.not_interested;
      default:
        return Icons.help_outline;
    }
  }

  String _getAvailabilityText(String availability) {
    switch (availability) {
      case 'indigo':
        return 'Best Choice';
      case 'blue':
        return 'Available';
      case 'lightBlue':
        return 'Out of Season';
      default:
        return 'Unknown';
    }
  }
}
