import 'package:flutter/material.dart';

void main() {
  runApp(const SustainableSeafoodApp());
}

class SustainableSeafoodApp extends StatelessWidget {
  const SustainableSeafoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ConsumptionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ConsumptionScreen extends StatefulWidget {
  const ConsumptionScreen({super.key});

  @override
  _SeafoodGuideScreenState createState() => _SeafoodGuideScreenState();
}

class _SeafoodGuideScreenState extends State<ConsumptionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Sustainable Choices'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0), // Adjust padding for TabBar width
              height: 50, // Set height of the bar for matching size
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                    25), // Circular border for smooth rounded effect
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                indicatorSize: TabBarIndicatorSize
                    .tab, // Ensures the white indicator fills the selected tab
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold), // Style for active tab
                unselectedLabelStyle:
                    const TextStyle(fontSize: 13.0), // Style for inactive tab
                indicatorPadding: const EdgeInsets.symmetric(
                    vertical: 5), // Decrease the white indicator height
                tabs: const [
                  Tab(text: 'Good for Consumption'),
                  Tab(text: 'Not Good for Consumption'),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                GoodForConsumptionScreen(),
                NotGoodForConsumptionScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//good for consumption screen
class GoodForConsumptionScreen extends StatelessWidget {
  const GoodForConsumptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        SeaCreatureCard(
          imageUrl: 'assets/images/cuttlefish2.png',
          name: 'Cuttlefish',
        ),
        SeaCreatureCard(
          imageUrl: 'assets/images/blue_crab.png',
          name: 'Blue Crab',
        ),
        SeaCreatureCard(
          imageUrl: 'assets/images/red_snapper.png',
          name: 'Red Snapper',
        ),
        SeaCreatureCard(
          imageUrl: 'assets/images/oyster.png',
          name: 'Oyster',
        ),
        SeaCreatureCard(
          imageUrl: 'assets/images/prawns.png',
          name: 'Prawns',
        ),
      ],
    );
  }
}

//not good for consumption screen
class NotGoodForConsumptionScreen extends StatelessWidget {
  const NotGoodForConsumptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        SeaCreatureCard(
          imageUrl: 'assets/images/striped_pajama_squid.png',
          name: 'Striped Pajama Squid',
        ),
        SeaCreatureCard(
          imageUrl: 'assets/images/whale_shark.png',
          name: 'Whale Shark',
        ),
        SeaCreatureCard(
          imageUrl: 'assets/images/atlantic_cod.png',
          name: 'Atlantic Cod',
        ),
        SeaCreatureCard(
          imageUrl: 'assets/images/grouper2.png',
          name: 'Grouper',
        ),
        SeaCreatureCard(
          imageUrl: 'assets/images/monkfish.png',
          name: 'Monkfish',
        ),
      ],
    );
  }
}

// SeaCreatureCard widget to display a sea creature
class SeaCreatureCard extends StatelessWidget {
  final String imageUrl;
  final String name;

  const SeaCreatureCard({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image.asset(
              imageUrl,
              height: 150, // Increased card height
              width: double.infinity,
              fit: BoxFit.cover, // Image covers the entire card
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.black54,
              width: double.infinity,
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
