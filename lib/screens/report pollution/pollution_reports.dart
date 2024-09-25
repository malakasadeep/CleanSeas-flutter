import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:clean_seas_flutter/screens/report pollution/pollution_details_screen.dart';
import 'package:clean_seas_flutter/widgets/report_pollution/pollution_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AllPollutionReportsPage extends StatefulWidget {
  @override
  _AllPollutionReportsPageState createState() =>
      _AllPollutionReportsPageState();
}

class _AllPollutionReportsPageState extends State<AllPollutionReportsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSearching = false; // Track if the search field is visible
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Function to toggle the search bar visibility
  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      _searchQuery = ''; // Clear the search query
      _searchController.clear();
    });
  }

  // Function to fetch reports based on city name search
  Stream<QuerySnapshot> _getFilteredReports([double? severity]) {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection('pollutionReports');

    // Print the current search query
    print('Search Query: $_searchQuery');

    // Apply the city search if there's a query
    if (_searchQuery.isNotEmpty) {
      // Convert the search query to lowercase
      String searchQueryLower = _searchQuery.toLowerCase();
      print('Filtering by city: $searchQueryLower');

      // Use lower case for the query
      query = query
          .where('normalizedCity', isGreaterThanOrEqualTo: searchQueryLower)
          .where('normalizedCity',
              isLessThanOrEqualTo: searchQueryLower + '\uf8ff');
    }

    // Apply severity filter if provided
    if (severity != null) {
      query = query.where('pollutionSeverity', isEqualTo: severity);
    }

    // Debug the final query
    print('Final Query: $query');

    return query.orderBy('createdAt', descending: true).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: _isSearching
            ? _buildSearchField() // Show search field when searching
            : Text(
                'All Pollution Incidence',
                style: GoogleFonts.raleway(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
        centerTitle: true,
        automaticallyImplyLeading: false, // Removes the back arrow
        actions: [
          IconButton(
            icon: Icon(
              _isSearching
                  ? Iconsax.close_circle_copy
                  : Iconsax.search_normal_1_copy,
              color: Colors.black,
            ),
            onPressed: _toggleSearch,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: const Color.fromARGB(255, 141, 141, 141),
          labelStyle: GoogleFonts.raleway(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'Low'),
            Tab(text: 'Moderate'),
            Tab(text: 'High'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildReportList(), // For the "All" tab, fetch all reports
          _buildReportList(1), // Low severity
          _buildReportList(2), // Moderate severity
          _buildReportList(3), // High severity
        ],
      ),
    );
  }

  // Build the search field
  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: 'Search by city',
        hintStyle: GoogleFonts.raleway(
            color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w400),
        border: InputBorder.none,
      ),
      onChanged: (query) {
        setState(() {
          _searchQuery = query;
        });
      },
    );
  }

  Widget _buildReportList([double? severity]) {
    return StreamBuilder(
      stream: _getFilteredReports(severity),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: SpinKitCircle(
            color: darkBlue,
            size: 50.0,
          ));
        }

        final reports = snapshot.data!.docs;

        if (reports.isEmpty) {
          return Center(child: Text('No reports available.'));
        }

        return ListView.builder(
          itemCount: reports.length,
          itemBuilder: (context, index) {
            var reportData = reports[index].data() as Map<String, dynamic>;

            return PollutionCard(
              imageUrl: (reportData['imageUrls'] != null &&
                      reportData['imageUrls'].isNotEmpty)
                  ? reportData['imageUrls'][0]
                  : 'https://img.freepik.com/free-vector/water-pollution-with-plastic-products_1308-33781.jpg?w=826&t=st=1726823845~exp=1726824445~hmac=b6b5285f2370a624790153521a389662eab324ee7dd46e4c359d5384dc44da77',
              pollutionType: reportData['pollutionType'],
              pollutionSeverity: reportData['pollutionSeverity'],
              reporterName: reportData['reporterName'],
              incidentDate: DateTime.parse(reportData['incidentDate']),
              city: reportData['city'],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PollutionDetailsPage(
                      reportId: reports[index].id,
                      reportData: reportData,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
