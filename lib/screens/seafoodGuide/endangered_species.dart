import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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

final List<EndangeredSpecies> endangeredSpeciess = [
  EndangeredSpecies(
    id: '2',
    name: 'Hawksbil Turtle',
    description:
        'This Hawksbil Turtle has a long, scaleless body and a large, distinct dorsal fin.',
    longDescription:
        'The Hawksbil Turtle is a small but eye-catching species of blenny that inhabits shallow coral reefs and rocky shorelines throughout the Western Atlantic, from the Caribbean to the Gulf of Mexico. Despite their diminutive size, usually growing no more than 5 centimeters in length, Sailfin Blennies are well-known for their bold and striking dorsal fin, which resembles a sail and can be raised dramatically to attract mates or deter rivals',
    imageUrl: 'assets/images/turtle.png',
  ),
  EndangeredSpecies(
    id: '3',
    name: 'Orange Roughy',
    description:
        'The Orange Roughy is scientifically known as Hippocampus kuda.',
    longDescription:
        'Orange Roughy are small marine fish that are found in shallow tropical and temperate waters around the world. They are known for their horse-like head and their prehensile tail, which they use to anchor themselves to coral or seaweed. Seahorses have a unique appearance and are among the most distinctive fish in the ocean.',
    imageUrl: 'assets/images/orange_roughy.png',
  ),
  EndangeredSpecies(
    id: '4',
    name: 'Hawain Squid',
    description:
        'Homarus gammarus, the European or common Squid, which is blue while alive.',
    longDescription:
        'The Squid, scientifically known as Homarus gammarus, is an extraordinary variant of the European lobster and is famous for its striking cobalt-blue coloration, which is a rare genetic mutation found in about 1 in 2 million lobsters. Typically, lobsters are brownish-green or reddish-brown, camouflaging well with the seabed. However, the blue lobsters vibrant hue is the result of an overproduction of a particular protein, creating an eye-catching appearance',
    imageUrl: 'assets/images/squid.png',
  ),
  EndangeredSpecies(
    id: '5',
    name: 'Whale Shark',
    description:
        'The Whale Shark is one of the large number of perciform fishes in the family.',
    longDescription:
        'The Whale Shark has a robust, elongated body covered in vertical, dark stripes or bars that become more pronounced when the fish is excited or stressed. Its color can range from pale cream to brownish-red, depending on its surroundings and behavior, making it an expert at blending in with coral reefs, rocky outcrops, and seagrass beds. They can grow up to 1.2 meters (4 feet) in length and weigh as much as 25 kilograms (55 pounds)',
    imageUrl: 'assets/images/whale_shark.png',
  ),
];

class SeafoodGuideScreens extends StatefulWidget {
  const SeafoodGuideScreens({Key? key}) : super(key: key);

  @override
  _SeafoodGuideScreensState createState() => _SeafoodGuideScreensState();
}

class _SeafoodGuideScreensState extends State<SeafoodGuideScreens> {
  List<String> favorites = [];
  TextEditingController searchController = TextEditingController();
  List<EndangeredSpecies> filteredEndangeredSpecies = endangeredSpeciess;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterEndangeredSpecies);
  }

  void _filterEndangeredSpecies() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredEndangeredSpecies = endangeredSpeciess
          .where((species) => species.name.toLowerCase().contains(query))
          .toList();
    });
  }

  void toggleFavorite(String species) {
    setState(() {
      if (favorites.contains(species)) {
        favorites.remove(species);
      } else {
        favorites.add(species);
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlue,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: backgroundBlue,
            flexibleSpace: FlexibleSpaceBar(
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
                          Colors.black.withOpacity(0.7)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                'Endangered Sea Creatures',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.3),
                child: IconButton(
                  icon: Icon(Iconsax.arrow_circle_left, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildSearchBar(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: EndangeredSpeciesCard(
                        imageUrl: filteredEndangeredSpecies[index].imageUrl,
                        name: filteredEndangeredSpecies[index].name,
                        description:
                            filteredEndangeredSpecies[index].description,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EndangeredSpeciesDetailScreen(
                                endangeredSpecies:
                                    filteredEndangeredSpecies[index],
                              ),
                            ),
                          );
                        },
                        isFavorite: favorites
                            .contains(filteredEndangeredSpecies[index].name),
                        onFavoriteToggle: () => toggleFavorite(
                            filteredEndangeredSpecies[index].name),
                      ),
                    ),
                  ),
                );
              },
              childCount: filteredEndangeredSpecies.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search for Endangered Sea Creature',
          prefixIcon: Icon(Icons.search, color: Colors.blue),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 130,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: Image.asset(
                  imageUrl,
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Read more',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
