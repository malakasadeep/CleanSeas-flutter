import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:clean_seas_flutter/controllers/user_controller.dart';
import 'package:clean_seas_flutter/models/user_model.dart';
import 'package:clean_seas_flutter/screens/report%20pollution/pollution_details_screen.dart';
import 'package:clean_seas_flutter/screens/report%20pollution/report_pollution_screen.dart';
import 'package:clean_seas_flutter/screens/report%20pollution/user_reportings_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UserProfile extends StatefulWidget {
  final UserModel loggedInUser;
  final UserController _userController = UserController();

  UserProfile({super.key, required this.loggedInUser});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Future<List<MyPollutionReportingCards>> userReports;

  @override
  void initState() {
    super.initState();
    userReports = _fetchUserReports();
  }

  Future<List<MyPollutionReportingCards>> _fetchUserReports() async {
    List<MyPollutionReportingCards> reportsList = [];

    try {
      // Fetch user's pollution reports, sorted by 'createdAt' in descending order
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('pollutionReports')
          .where('contactInfo', isEqualTo: widget.loggedInUser.email)
          .orderBy('createdAt', descending: true)
          .limit(3) // Limit to the latest 3 reports
          .get();

      // Convert documents into MyPollutionReportingCards list
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        var imageUrl = data['imageUrls'] != null && data['imageUrls'].isNotEmpty
            ? data['imageUrls'][0]
            : 'https://via.placeholder.com/150'; // Fallback image
        var city = data['city'] ?? 'Unknown City';
        var createdAt = data['createdAt'] != null
            ? (data['createdAt'] as Timestamp).toDate()
            : DateTime.now(); // Fallback to current date

        reportsList.add(MyPollutionReportingCards(
          title: data['pollutionType'] ?? 'Unknown Pollution',
          image: imageUrl,
          city: city,
          createdAt: createdAt,
        ));
      }
    } catch (e) {
      print('Error fetching user reports: $e');
    }

    return reportsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlue,
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 30.0, 12.0, 2.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context); // Back navigation
                    },
                    backgroundColor: Colors.white,
                    child: const Icon(Iconsax.arrow_circle_left,
                        color: Colors.black),
                  ),
                ),
                Text(
                  'Profile',
                  style: GoogleFonts.raleway(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://www.shareicon.net/data/512x512/2016/05/24/770117_people_512x512.png",
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.loggedInUser.fullName.isNotEmpty
                    ? widget.loggedInUser.fullName
                    : widget.loggedInUser.ngoName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(widget.loggedInUser.email),
              Text(widget.loggedInUser.userType),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Text(
                  "My Pollution Reportings",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserReportingsPage(
                        loggedInUser: widget.loggedInUser,
                      ),
                    ),
                  );
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: Color.fromARGB(255, 8, 119, 171),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),

          // Fetch and display the user's reports
          FutureBuilder<List<MyPollutionReportingCards>>(
            future: userReports,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: SpinKitCircle(
                  color: darkBlue,
                  size: 50.0,
                ));
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error fetching reports'));
              }

              List<MyPollutionReportingCards> reports = snapshot.data ?? [];

              return SizedBox(
                height: 160,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: reports.length + 1, // +1 for the "Add" card
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // First card is the "Add Pollution Report" card
                      return SizedBox(
                        width: 140,
                        child: Card(
                          shadowColor: Colors.black12,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReportPollutionScreen(
                                    loggedInUser: widget.loggedInUser,
                                  ),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Icon(
                                    Iconsax.document_upload,
                                    color: Color.fromARGB(255, 43, 90, 171),
                                    size: 70,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Report Marine Pollution",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      final card = reports[index - 1];
                      return SizedBox(
                        width: 160,
                        child: Card(
                          shadowColor: Colors.black12,
                          child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      card.image,
                                      width: double.infinity,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    card.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 1),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Iconsax.location_copy,
                                        color:
                                            Color.fromARGB(255, 119, 144, 165),
                                        size: 18,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        card.city,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  separatorBuilder: (context, index) =>
                      const Padding(padding: EdgeInsets.only(right: 5)),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          ...List.generate(
            customListTiles.length,
            (index) {
              final tile = customListTiles[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: ListTile(
                      leading: Icon(tile.icon),
                      title: Text(tile.title),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        if (tile.title == "Logout") {
                          widget._userController.logoutUser(context);
                        }
                      }),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class MyPollutionReportingCards {
  final String title;
  final String image;
  final String city;
  final DateTime createdAt; // Add createdAt field

  MyPollutionReportingCards({
    required this.title,
    required this.image,
    required this.city,
    required this.createdAt,
  });
}

class CustomListTile {
  final IconData icon;
  final String title;
  CustomListTile({
    required this.icon,
    required this.title,
  });
}

List<CustomListTile> customListTiles = [
  CustomListTile(
    icon: Icons.insights,
    title: "My Participations",
  ),
  CustomListTile(
    icon: Icons.favorite_outline_outlined,
    title: "Saved Articles",
  ),
  CustomListTile(
    title: "Notifications",
    icon: Icons.notifications_active_outlined,
  ),
  CustomListTile(
    title: "Logout",
    icon: Icons.logout_outlined,
  ),
];
