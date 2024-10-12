import 'package:flutter/material.dart';
import 'package:clean_seas_flutter/models/user_model.dart';
import 'package:clean_seas_flutter/widgets/event_appbart.dart';
import 'package:clean_seas_flutter/widgets/search_bar.dart';
import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:clean_seas_flutter/widgets/near_event_card.dart';
import 'package:clean_seas_flutter/widgets/featured_event_card.dart';
import 'package:clean_seas_flutter/controllers/event_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clean_seas_flutter/models/event.dart';
import 'package:clean_seas_flutter/screens/event/one_event_screen.dart';

class EventScreen extends StatefulWidget {
  final UserModel loggedInUser;

  const EventScreen({super.key, required this.loggedInUser});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final EventController eventController = EventController();
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventAppBar(loggedInUser: widget.loggedInUser),
              const SizedBox(height: 10),
              HomeSearchBar(
                controller: searchController,
                onChanged: (query) {
                  setState(() {
                    searchQuery =
                        query.toLowerCase(); // Update the search query
                  });
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder<List<Event>>(
                  future: eventController.fetchEvents(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No events found.'));
                    }

                    final events = snapshot.data!;

                    // Filter events based on the search query
                    final filteredEvents = events.where((event) {
                      final eventTitleLower = event.title.toLowerCase();
                      return eventTitleLower.contains(searchQuery);
                    }).toList();

                    // Further filter for events in Sri Lanka
                    final sriLankaEvents = filteredEvents
                        .where((event) => _isInSriLanka(
                            event.location.latitude, event.location.longitude))
                        .toList();

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Near From You',
                                style: GoogleFonts.raleway(
                                  color: const Color.fromARGB(255, 6, 6, 6),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'View All',
                                  style: GoogleFonts.raleway(
                                    color:
                                        const Color.fromARGB(255, 83, 110, 173),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          SizedBox(
                            height: 250,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: sriLankaEvents.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: NearEventCard(
                                    event: sriLankaEvents[index],
                                    wid: 200,
                                    hig: 250,
                                    fsize: 1,
                                    onTap: () => _onNearEventCardTapped(
                                        sriLankaEvents[index]),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Featured Events',
                                style: GoogleFonts.raleway(
                                  color: const Color.fromARGB(255, 6, 6, 6),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'View All',
                                  style: GoogleFonts.raleway(
                                    color:
                                        const Color.fromARGB(255, 83, 110, 173),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Column(
                            children: List.generate(
                              filteredEvents.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: FeaturedEvent(
                                    event: filteredEvents[index],
                                    onTap: () => _onNearEventCardTapped(
                                        filteredEvents[index])),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isInSriLanka(double latitude, double longitude) {
    return (latitude >= 5.8 && latitude <= 9.8) &&
        (longitude >= 70 && longitude <= 81.6);
  }

  void _onNearEventCardTapped(Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OneEventScreen(event: event),
      ),
    );
  }
}
