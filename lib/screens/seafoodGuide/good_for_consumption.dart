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

// Sea creature model class
class SeaCreature {
  final String id;
  final String name;
  final String reason;
  final String imageUrl;
  final bool isTrue;

  SeaCreature({
    required this.id,
    required this.name,
    required this.reason,
    required this.imageUrl,
    required this.isTrue,
  });
}

// List of sea creatures good for consumption
final List<SeaCreature> goodForConsumptionSeaCreatures = [
  SeaCreature(
    id: '1',
    name: 'Cuttlefish',
    reason: 'Cuttlefish is rich in protein and omega-3 fatty acids.',
    imageUrl: 'assets/images/cuttlefish2.png',
    isTrue: true,
  ),
  SeaCreature(
    id: '2',
    name: 'Blue Crab',
    reason: 'Blue crabs are harvested sustainably and are nutritious.',
    imageUrl: 'assets/images/blue_crab.png',
    isTrue: true,
  ),
  SeaCreature(
    id: '3',
    name: 'Red Snapper',
    reason:
        'Red snapper is a lean source of protein and has low mercury levels.',
    imageUrl: 'assets/images/red_snapper.png',
    isTrue: true,
  ),
  SeaCreature(
    id: '4',
    name: 'Oyster',
    reason: 'Oysters are eco-friendly and contain essential nutrients.',
    imageUrl: 'assets/images/oyster.png',
    isTrue: true,
  ),
  SeaCreature(
    id: '5',
    name: 'Prawns',
    reason: 'Prawns are low in fat and an excellent source of protein.',
    imageUrl: 'assets/images/prawns.png',
    isTrue: true,
  ),
];

// List of sea creatures not good for consumption
final List<SeaCreature> notGoodForConsumptionSeaCreatures = [
  SeaCreature(
    id: '1',
    name: 'Striped Pajama Squid',
    reason:
        'The Striped Pajama Squid, also known as Sepioloidea lineolata, is classified as endangered due to a combination of factors primarily related to human activities and environmental changes. Habitat destruction is a major concern, as coastal areas where these squids reside are increasingly affected by pollution, urbanization, and marine development. Overfishing also plays a role, as the squid is sometimes caught unintentionally in commercial fishing nets. Additionally, climate change has led to rising ocean temperatures and habitat degradation, further reducing their population. Conservation efforts are needed to protect the Striped Pajama Squid and its ecosystem from these threats.',
    imageUrl: 'assets/images/striped_pajama_squid.png',
    isTrue: false,
  ),
  SeaCreature(
    id: '2',
    name: 'Whale Shark',
    reason:
        'The Whale Shark (Rhincodon typus), the largest fish in the ocean, is classified as endangered due to a combination of human activities and environmental factors. One of the primary threats is illegal and unregulated fishing, where Whale Sharks are targeted for their fins, meat, and oil. Accidental capture in fishing gear, known as bycatch, also contributes to population decline. Additionally, habitat degradation caused by pollution, coastal development, and boat collisions endangers these gentle giants. Climate change, which affects their migratory patterns and food sources, further exacerbates their vulnerability. Efforts to protect the Whale Shark focus on reducing fishing pressures, protecting critical habitats, and improving global conservation awareness.',
    imageUrl: 'assets/images/whale_shark.png',
    isTrue: false,
  ),
  SeaCreature(
    id: '3',
    name: 'Atlantic Cod',
    reason:
        'The Atlantic Cod (Gadus morhua), once abundant in the North Atlantic, is now considered endangered due to overfishing and environmental changes. Decades of intense commercial fishing, especially during the 20th century, led to dramatic population declines. The cods slow growth and late maturity made it particularly vulnerable to unsustainable fishing practices. In addition to overfishing, habitat degradation, pollution, and changes in sea temperature due to climate change have disrupted the cods spawning grounds and food availability. Conservation efforts, including fishing quotas and marine protected areas, aim to restore Atlantic Cod populations, but recovery has been slow and uncertain due to the complexity of marine ecosystems and ongoing challenges in enforcement.',
    imageUrl: 'assets/images/atlantic_cod.png',
    isTrue: false,
  ),
  SeaCreature(
    id: '4',
    name: 'Grouper',
    reason:
        'Groupers, a family of large reef-dwelling fish, are facing endangerment primarily due to overfishing and habitat destruction. These fish are highly sought after for their meat, leading to intense fishing pressures, often at unsustainable levels. Groupers are particularly vulnerable to overfishing because they are slow-growing, late to mature, and have specific spawning behaviors, often aggregating in large numbers at predictable times, making them easy targets. Additionally, habitat loss, especially the degradation of coral reefs and coastal areas where groupers reside, has further diminished their populations. Climate change, which affects ocean temperatures and reef ecosystems, also poses a long-term threat to their survival. Conservation efforts include establishing marine protected areas, fishing regulations, and measures to protect critical spawning grounds',
    imageUrl: 'assets/images/grouper2.png',
    isTrue: false,
  ),
  SeaCreature(
    id: '5',
    name: 'Monkfish',
    reason:
        'The Monkfish (Lophius piscatorius), also known as the Anglerfish, is considered vulnerable due to overfishing and habitat degradation. Highly prized for its firm and tasty meat, Monkfish has been targeted by commercial fisheries, particularly in Europe and North America, leading to significant population declines. The species slow growth and late maturity make it susceptible to over-exploitation, as it takes time for populations to recover. In addition, bottom trawling, a fishing method commonly used to catch Monkfish, destroys the seafloor habitat where they live, further impacting their environment. Conservation measures, including catch limits and habitat protections, have been implemented in some areas to help safeguard Monkfish populations, but enforcement and effective management remain critical to their recovery.',
    imageUrl: 'assets/images/monkfish.png',
    isTrue: false,
  ),
];

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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(fontSize: 13.0),
                indicatorPadding: const EdgeInsets.symmetric(vertical: 5),
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

// good for consumption screen
class GoodForConsumptionScreen extends StatelessWidget {
  const GoodForConsumptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: goodForConsumptionSeaCreatures.map((creature) {
        return SeaCreatureCard(
          imageUrl: creature.imageUrl,
          name: creature.name,
          
        );
      }).toList(),
    );
  }
}

// not good for consumption screen
class NotGoodForConsumptionScreen extends StatelessWidget {
  const NotGoodForConsumptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: notGoodForConsumptionSeaCreatures.map((creature) {
        return SeaCreatureCard(
          imageUrl: creature.imageUrl,
          name: creature.name,
        );
      }).toList(),
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
