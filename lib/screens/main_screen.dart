import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Iconsax.home,
                color: Color.fromARGB(255, 177, 177, 177),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Iconsax.search_normal,
                color: Color.fromARGB(255, 177, 177, 177),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.print,
                color: Color.fromARGB(255, 177, 177, 177),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Iconsax.profile_tick,
                color: Color.fromARGB(255, 177, 177, 177),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
