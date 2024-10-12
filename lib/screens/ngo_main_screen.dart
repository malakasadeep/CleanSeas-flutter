import 'package:clean_seas_flutter/models/user_model.dart';
import 'package:clean_seas_flutter/screens/education/education_resources_home_screen.dart';
import 'package:clean_seas_flutter/screens/event/create_event_screen.dart';
import 'package:clean_seas_flutter/screens/event/event_screen.dart';
import 'package:clean_seas_flutter/screens/event/one_event_screen.dart';
import 'package:clean_seas_flutter/screens/report%20pollution/pollution_reports.dart';
import 'package:clean_seas_flutter/screens/report%20pollution/report_pollution_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter/material.dart';
import 'package:clean_seas_flutter/constants/colours.dart';

class NgoMainScreen extends StatefulWidget {
  final UserModel loggedInUser;
  const NgoMainScreen({super.key, required this.loggedInUser});

  @override
  State<NgoMainScreen> createState() => _NgoMainScreenState();
}

class _NgoMainScreenState extends State<NgoMainScreen> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    // Initialize the screens list inside the build method
    List<Widget> screens = [
      EventScreen(loggedInUser: widget.loggedInUser),
      AllPollutionReportsPage(
        loggedInUser: widget.loggedInUser,
      ),
      Scaffold(),
      EducationResourcesHomeScreen(),
    ];

    return Scaffold(
      backgroundColor: backgroundBlue,
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateEventScreen()));
        },
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 45, 44, 44),
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 177, 177, 177),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 70,
        color: const Color.fromARGB(255, 45, 44, 44),
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Iconsax.home,
                    color: Color.fromARGB(255, 177, 177, 177),
                  ),
                  onPressed: () => setState(() {
                    currentTab = 0;
                  }),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Iconsax.note_favorite,
                    color: Color.fromARGB(255, 177, 177, 177),
                  ),
                  onPressed: () => setState(() {
                    currentTab = 1;
                  }),
                ),
              ],
            ),
            const SizedBox(width: 40), // Space for the FloatingActionButton
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.food_bank,
                    color: Color.fromARGB(255, 177, 177, 177),
                  ),
                  onPressed: () => setState(() {
                    currentTab = 2;
                  }),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Iconsax.book,
                    color: Color.fromARGB(255, 177, 177, 177),
                  ),
                  onPressed: () => setState(() {
                    currentTab = 3;
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
      body: screens[currentTab],
    );
  }
}
