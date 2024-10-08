import 'package:flutter/material.dart';

void main() {
  runApp(ConsumptionDetails());
}

class ConsumptionDetails extends StatelessWidget {
  const ConsumptionDetails({super.key});

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
                child: ConsumptionDetailsCard(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ConsumptionDetailsCard extends StatelessWidget {
  const ConsumptionDetailsCard({super.key});

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
                    'assets/images/blue_crab.png',
                    height: 180,
                    width: 230,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16.0),

                // Title
                Text(
                  'Blue crab',
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
                  'Blue crab is a healthy and nutritious seafood choice, rich in high-quality protein and essential omega-3 fatty acids that support heart and brain health. It\'s low in fat and calories, making it a lean option, while also providing key vitamins and minerals like vitamin B12, zinc, and selenium. Additionally, blue crabs are often harvested sustainably, making them an environmentally responsible choice. Their mild, sweet flavor adds versatility to many dishes, from salads to crab cakes, making them both delicious and good for overall well-being.',
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
              'Good for Consumption',
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
