import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:clean_seas_flutter/models/user_model.dart';
import 'package:clean_seas_flutter/screens/report%20pollution/pollution_details_screen.dart';
import 'package:clean_seas_flutter/widgets/report_pollution/pollution_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:awesome_dialog/awesome_dialog.dart'; // Add AwesomeDialog for alerts

class UserReportingsPage extends StatefulWidget {
  final UserModel loggedInUser; // Pass the current user's data
  UserReportingsPage({required this.loggedInUser});

  @override
  _UserReportingsPageState createState() => _UserReportingsPageState();
}

class _UserReportingsPageState extends State<UserReportingsPage> {
  bool _showSwipeHint = true; // Track whether to show the swipe hint

  Stream<QuerySnapshot> _getUserReports() {
    return FirebaseFirestore.instance
        .collection('pollutionReports')
        .where('contactInfo',
            isEqualTo: widget.loggedInUser.email) // Filter by user email
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  void _deleteReport(String reportId) async {
    try {
      await FirebaseFirestore.instance
          .collection('pollutionReports')
          .doc(reportId)
          .delete();
      _showSuccessDialog('Report deleted successfully!');
    } catch (error) {
      _showErrorDialog('Failed to delete the report.');
    }
  }

  void _updateReport(String reportId, Map<String, dynamic> reportData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PollutionDetailsPage(
          loggedInUser: widget.loggedInUser,
          reportId: reportId,
          reportData: reportData,
        ),
      ),
    );
  }

  void _showDeleteConfirmation(String reportId) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Delete Report',
      desc: 'Are you sure you want to delete this report?',
      btnCancelOnPress: () {},
      btnOkOnPress: () => _deleteReport(reportId),
      btnOkText: 'Delete',
      btnCancelText: 'Cancel',
    ).show();
  }

  void _showSuccessDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      headerAnimationLoop: false,
      animType: AnimType.scale,
      title: 'Success',
      desc: message,
      btnOkOnPress: () {},
    ).show();
  }

  void _showErrorDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      headerAnimationLoop: false,
      animType: AnimType.scale,
      title: 'Error',
      desc: message,
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlue,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 30.0, 12.0, 2.0),
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
                SizedBox(height: 10),
                Text(
                  'My Pollution Reports',
                  style: GoogleFonts.raleway(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                _showSwipeHint
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _showSwipeHint = false;
                          });
                        },
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Swipe left or right on a report to edit or delete.',
                                  style: GoogleFonts.raleway(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.close,
                                    color: Colors.red, size: 20),
                                onPressed: () {
                                  setState(() {
                                    _showSwipeHint = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
          Expanded(
            child: _buildReportList(), // Expanded to fill remaining space
          ),
        ],
      ),
    );
  }

  Widget _buildReportList() {
    return StreamBuilder(
      stream: _getUserReports(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SpinKitCircle(
              color: darkBlue,
              size: 50.0,
            ),
          );
        }

        final reports = snapshot.data!.docs;

        if (reports.isEmpty) {
          return Center(child: Text('No reports available.'));
        }

        return ListView.builder(
          itemCount: reports.length,
          itemBuilder: (context, index) {
            var reportData = reports[index].data() as Map<String, dynamic>;
            String reportId = reports[index].id;

            return Slidable(
              key: ValueKey(reportId),
              startActionPane: ActionPane(
                motion: const StretchMotion(),
                extentRatio: 0.5, // Adjusted to cover half of the screen
                children: [
                  SlidableAction(
                    onPressed: (context) => _updateReport(reportId, reportData),
                    backgroundColor: Colors.blueAccent.shade200,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                    borderRadius: BorderRadius.circular(16),
                    padding: EdgeInsets.all(10),
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                extentRatio: 0.5, // Adjusted to cover half of the screen
                children: [
                  SlidableAction(
                    onPressed: (context) => _showDeleteConfirmation(reportId),
                    backgroundColor: Colors.redAccent.shade200,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                    borderRadius: BorderRadius.circular(16),
                    padding: EdgeInsets.all(10),
                  ),
                ],
              ),
              child: PollutionCard(
                imageUrl: (reportData['imageUrls'] != null &&
                        reportData['imageUrls'].isNotEmpty)
                    ? reportData['imageUrls'][0]
                    : 'https://img.freepik.com/free-vector/water-pollution-with-plastic-products.jpg',
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
                        loggedInUser: widget.loggedInUser,
                        reportId: reportId,
                        reportData: reportData,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
