import 'package:clean_seas_flutter/screens/seafoodGuide/good_for_consumption.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(ConsumptionDetails());
// }

class ConsumptionDetails extends StatelessWidget {
  final SeaCreature creature;
  const ConsumptionDetails({
    super.key,
    required this.creature, // Pass the SeaCreature object to the constructor
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: Scaffold(
        backgroundColor: Color(0xFFDAE8F0), // Light blue background color
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                // Scrollable container
                child: ConsumptionDetailsCard(creature: creature),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ConsumptionDetailsCard extends StatelessWidget {
  final SeaCreature creature;
  const ConsumptionDetailsCard({super.key, required this.creature});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // White Card
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5.0,
          child: Container(
            width: 320,
            // height: 800,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ), // Adjust space to avoid overlap with banner

                // Image of Blue Crab
                ClipRRect(
                  borderRadius: BorderRadius.circular(7.0),
                  child: Image.asset(
                    creature.imageUrl,
                    height: 180,
                    width: 230,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16.0),

                // Title
                Text(
                  creature.name,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
                SizedBox(height: 8.0),

                // 'Reason' Header
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Reason:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                ),
                SizedBox(height: 8.0),

                // Description Text
                Text(
                  creature.reason,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),

        // 'Good for Consumption' Banner
        Positioned(
          top: 20,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 200, 223, 234),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 18.0),
            child: Text(
              creature.isTrue
                  ? 'Good for Consumption'
                  : 'Not Good for Consumption',
              style: TextStyle(
                color: Colors.blue[900],
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
