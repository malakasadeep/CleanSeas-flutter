import 'package:clean_seas_flutter/screens/event/create_event_screen.dart';
import 'package:clean_seas_flutter/screens/event/event_screen.dart';
import 'package:clean_seas_flutter/screens/event/one_event_screen.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter/material.dart';
import 'package:clean_seas_flutter/constants/colours.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;
  List screens = const [
    EventScreen(),
    OneEventScreen(),
    Scaffold(),
    Scaffold(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlue,
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateEventScreen()));
        },
        shape: CircleBorder(),
        backgroundColor: Color.fromARGB(255, 45, 44, 44),
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
                // Text(
                //   'Home',
                //   style: TextStyle(color: Color.fromARGB(255, 177, 177, 177)),
                // ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Iconsax.menu_board,
                    color: Color.fromARGB(255, 177, 177, 177),
                  ),
                  onPressed: () => setState(() {
                    currentTab = 1;
                  }),
                ),
                // Text(
                //   'Search',
                //   style: TextStyle(color: Color.fromARGB(255, 177, 177, 177)),
                // ),
              ],
            ),
            const SizedBox(width: 40), // Space for the FloatingActionButton
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.library_books,
                    color: Color.fromARGB(255, 177, 177, 177),
                  ),
                  onPressed: () => setState(() {
                    currentTab = 2;
                  }),
                ),
                // Text(
                //   'Print',
                //   style: TextStyle(color: Color.fromARGB(255, 177, 177, 177)),
                // ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Iconsax.flash_circle,
                    color: Color.fromARGB(255, 177, 177, 177),
                  ),
                  onPressed: () => setState(() {
                    currentTab = 3;
                  }),
                ),
                // Text(
                //   'Profile',
                //   style: TextStyle(color: Color.fromARGB(255, 177, 177, 177)),
                // ),
              ],
            ),
          ],
        ),
      ),
      body: screens[currentTab],
    );
  }
}
