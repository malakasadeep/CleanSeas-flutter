import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'endangered_species_details.dart';

class EndangeredSpecies {
  final String id;
  final String name;
  final String description;
  final String longDescription;
  final String imageUrl;

  EndangeredSpecies({
    required this.id,
    required this.name,
    required this.description,
    required this.longDescription,
    required this.imageUrl,
  });
}

final List<EndangeredSpecies> endangeredSpecies = [
  EndangeredSpecies(
    id: '1',
    name: 'Hawksbill Turtle',
    description:
        'This Hawksbill Turtle has a distinct shell pattern and is critically endangered.',
    longDescription:
        'The Hawksbill Turtle is a critically endangered sea turtle with a distinctive hawk-like beak. They play a crucial role in maintaining the health of coral reefs and are known for their beautiful shell pattern, which unfortunately has made them a target for the illegal wildlife trade.',
    imageUrl: 'assets/images/turtle.png',
  ),
  EndangeredSpecies(
    id: '2',
    name: 'Orange Roughy',
    description:
        'The Orange Roughy is a deep-sea fish known for its longevity and slow growth rate.',
    longDescription:
        'Orange Roughy are deep-sea fish that can live up to 250 years. They are slow-growing and late-maturing, making them particularly vulnerable to overfishing. Their populations have been severely depleted due to commercial fishing practices.',
    imageUrl: 'assets/images/orange_roughy.png',
  ),
  EndangeredSpecies(
    id: '3',
    name: 'Hawaiian Monk Seal',
    description:
        'The Hawaiian Monk Seal is one of the most endangered marine mammals in the world.',
    longDescription:
        'The Hawaiian Monk Seal is endemic to the Hawaiian Islands and is one of the rarest marine mammals in the world. They face numerous threats including habitat loss, entanglement in marine debris, and human disturbance. Conservation efforts are crucial for their survival.',
    imageUrl: 'assets/images/monk_seal.png',
  ),
  EndangeredSpecies(
    id: '4',
    name: 'Whale Shark',
    description:
        'The Whale Shark is the largest fish in the world and is vulnerable to extinction.',
    longDescription:
        'Whale Sharks are the gentle giants of the ocean, known for their distinctive spotted pattern and massive size. Despite being the largest fish in the world, they feed mainly on plankton. They are threatened by fishing, boat strikes, and marine pollution.',
    imageUrl: 'assets/images/whale_shark.png',
  ),
];

class EndangeredSeaCreaturesScreen extends StatefulWidget {
  const EndangeredSeaCreaturesScreen({Key? key}) : super(key: key);

  @override
  _EndangeredSeaCreaturesScreenState createState() =>
      _EndangeredSeaCreaturesScreenState();
}

class _EndangeredSeaCreaturesScreenState
    extends State<EndangeredSeaCreaturesScreen>
    with SingleTickerProviderStateMixin {
  List<String> favorites = [];
  TextEditingController searchController = TextEditingController();
  List<EndangeredSpecies> filteredEndangeredSpecies = endangeredSpecies;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterEndangeredSpecies);
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

  void _filterEndangeredSpecies() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredEndangeredSpecies = endangeredSpecies
          .where((species) => species.name.toLowerCase().contains(query))
          .toList();
    });
  }

  void toggleFavorite(String speciesId) {
    setState(() {
      if (favorites.contains(speciesId)) {
        favorites.remove(speciesId);
      } else {
        favorites.add(speciesId);
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
                  'Endangered Sea Creatures',
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
                        hintText: 'Search for Endangered Species',
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
                    child: filteredEndangeredSpecies.isNotEmpty
                        ? ListView.builder(
                            itemCount: filteredEndangeredSpecies.length,
                            itemBuilder: (context, index) {
                              final species = filteredEndangeredSpecies[index];
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
                                child: EndangeredSpeciesCard(
                                  imageUrl: species.imageUrl,
                                  name: species.name,
                                  description: species.description,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EndangeredSpeciesDetailScreen(
                                          endangeredSpecies: species,
                                        ),
                                      ),
                                    );
                                  },
                                  isFavorite: favorites.contains(species.id),
                                  onFavoriteToggle: () =>
                                      toggleFavorite(species.id),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              'No endangered species found.',
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

class EndangeredSpeciesCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const EndangeredSpeciesCard({
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
                  tag: 'endangeredSpecies_${name}',
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
