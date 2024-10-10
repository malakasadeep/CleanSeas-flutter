import 'package:clean_seas_flutter/screens/seafoodGuide/consumption_details.dart';
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
    reason:
        'Cuttlefish is a great option for consumption due to its high protein content, low fat, and abundance of essential nutrients like vitamins B12 and B6, phosphorus, and selenium, which contribute to overall health. Its tender, mild-flavored meat is highly versatile in cooking, making it a popular seafood choice. Importantly, cuttlefish is not currently listed as endangered, meaning it is generally considered a sustainable option for eating without harming ocean ecosystems.',
    imageUrl: 'assets/images/cuttlefish2.png',
    isTrue: true,
  ),
  SeaCreature(
    id: '2',
    name: 'Blue Crab',
    reason:
        'Blue crab is a good choice for consumption because it is rich in protein, low in calories, and a good source of vitamins like B12 and minerals such as zinc and selenium, which are important for overall health. Its sweet, tender meat is enjoyed in a variety of dishes. Blue crabs are not considered endangered, making them a sustainable option for seafood consumption, helping to maintain balance in marine ecosystems while providing a healthy and delicious food source',
    imageUrl: 'assets/images/blue_crab.png',
    isTrue: true,
  ),
  SeaCreature(
    id: '3',
    name: 'Red Snapper',
    reason:
        'Red snapper is considered a good option for consumption because of its firm texture, mild flavor, and high nutritional value, including being a good source of protein, omega-3 fatty acids, and essential vitamins like B12 and D. It is prized for its versatility in cooking, whether grilled, baked, or pan-fried. Red snapper populations are generally managed through regulations, and while not endangered, it is essential to choose sustainably caught varieties to ensure the health of the species and marine ecosystems.',
    imageUrl: 'assets/images/red_snapper.png',
    isTrue: true,
  ),
  SeaCreature(
    id: '4',
    name: 'Oyster',
    reason:
        'Oysters are a sustainable choice for consumption as they are not endangered and are farmed in environmentally friendly ways. They are packed with nutrients like zinc, iron, and omega-3 fatty acids, which are beneficial for heart and brain health. Oysters also help filter and clean the water in their habitat, making them beneficial to marine ecosystems. Choosing responsibly farmed or wild-caught oysters supports both personal health and the health of the oceans.',
    imageUrl: 'assets/images/oyster.png',
    isTrue: true,
  ),
  SeaCreature(
    id: '5',
    name: 'Prawns',
    reason:
        'Prawns are considered a good choice for consumption when sourced from sustainable and responsible fisheries or farms. They are rich in protein, vitamins, and minerals like selenium, which supports immune function. Wild-caught prawns from well-managed fisheries are typically a more sustainable option. It’s important to choose prawns that are certified by reputable sustainability programs, as overfishing and harmful farming practices can damage marine ecosystems. When sourced responsibly, prawns can be a healthy and eco-friendly addition to the diet.',
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
    reason: 'The Monkfish (Lophius piscatorius), ',
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
class GoodForConsumptionScreen extends StatefulWidget {
  const GoodForConsumptionScreen({super.key});

  @override
  State<GoodForConsumptionScreen> createState() =>
      _GoodForConsumptionScreenState();
}

class _GoodForConsumptionScreenState extends State<GoodForConsumptionScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: goodForConsumptionSeaCreatures.map((creature) {
        return SeaCreatureCard2(
          imageUrl: creature.imageUrl,
          name: creature.name,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConsumptionDetails(
                  creature: creature,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

// not good for consumption screen
class NotGoodForConsumptionScreen extends StatefulWidget {
  const NotGoodForConsumptionScreen({super.key});

  @override
  State<NotGoodForConsumptionScreen> createState() =>
      _NotGoodForConsumptionScreenState();
}

class _NotGoodForConsumptionScreenState
    extends State<NotGoodForConsumptionScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: notGoodForConsumptionSeaCreatures.map((creature) {
        return SeaCreatureCard2(
          imageUrl: creature.imageUrl,
          name: creature.name,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConsumptionDetailsCard(
                  creature: creature,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

// SeaCreatureCard widget to display a sea creature
class SeaCreatureCard2 extends StatefulWidget {
  final String imageUrl;
  final String name;
  final VoidCallback onTap;

  const SeaCreatureCard2({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.onTap,
  });

  @override
  State<SeaCreatureCard2> createState() => _SeaCreatureCardState();
}

class _SeaCreatureCardState extends State<SeaCreatureCard2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: widget.onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.asset(
                widget.imageUrl,
                height: 150, // Increased card height
                width: double.infinity,
                fit: BoxFit.cover, // Image covers the entire card
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.black54,
                width: double.infinity,
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
