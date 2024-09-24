import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:clean_seas_flutter/screens/report%20pollution/pollution_details_screen.dart';
import 'package:clean_seas_flutter/widgets/report_pollution/pollution_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllPollutionReportsPage extends StatefulWidget {
  @override
  _AllPollutionReportsPageState createState() =>
      _AllPollutionReportsPageState();
}

class _AllPollutionReportsPageState extends State<AllPollutionReportsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // Set to 4
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Stream<QuerySnapshot> _getFilteredReports([double? severity]) {
    if (severity != null) {
      return FirebaseFirestore.instance
          .collection('pollutionReports')
          .where('pollutionSeverity', isEqualTo: severity)
          .snapshots();
    }
    // Return all reports if no severity is specified
    return FirebaseFirestore.instance
        .collection('pollutionReports')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'All Pollution Incidence',
          style: GoogleFonts.raleway(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false, // Removes the back arrow
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
            Tab(text: 'All'), // Added the "All" tab
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

  Widget _buildReportList([double? severity]) {
    return StreamBuilder(
      stream: _getFilteredReports(severity),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
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
                  : 'https://img.freepik.com/free-vector/water-pollution-with-plastic-products_1308-33781.jpg?w=826&t=st=1726823845~exp=1726824445~hmac=b6b5285f2370a624790153521a389662eab324ee7dd46e4c359d5384dc44da77', // Show the first image if available
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
