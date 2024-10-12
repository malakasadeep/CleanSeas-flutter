import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomeSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const HomeSearchBar({
    super.key,
    required this.controller, // Pass the controller here
    required this.onChanged, // Pass the callback here
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: Row(
        children: [
          const Icon(Iconsax.search_normal),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller, // Attach the controller here
              onChanged: onChanged, // Trigger the callback on text change
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search address or near you",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
