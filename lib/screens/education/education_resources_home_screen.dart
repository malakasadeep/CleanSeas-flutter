import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:clean_seas_flutter/models/EducationArticle.dart';
import 'package:clean_seas_flutter/models/education_video.dart';
import 'package:clean_seas_flutter/screens/education/education_video_page.dart';
import 'package:clean_seas_flutter/screens/education/view_all_articles_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart'; // For sea creature animations
import 'package:animated_text_kit/animated_text_kit.dart'; // For text animations

class EducationResourcesHomeScreen extends StatelessWidget {
  EducationResourcesHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Text(
              'Education Resources',
              style: GoogleFonts.raleway(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            SingleChildScrollView(
              child: Stack(
                children: [
                  // Background Lottie animation for "What is Education Feature?"
                  Positioned(
                    top: -50,
                    left: 0,
                    right: 0,
                    child: Lottie.asset(
                      'assets/images/bg.json', // Replace with your Lottie animation file
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Section with Banner and Animation
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              // Banner Text on the left
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: backgroundBlue.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Protect Sea Creatures',
                                    style: GoogleFonts.balooTamma2(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      10), // Spacing between text and animation
                              // Lottie Animation on the right
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: Lottie.asset(
                                  'assets/images/lot.json', // Replace with your Lottie animation file
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Animated Text and Sea Creatures Section
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 56),
                              // Animated Text
                              AnimatedTextKit(
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    'What is the Education Feature?',
                                    textStyle: GoogleFonts.balooTamma2(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 6, 52,
                                          89), // Extra dark color for text
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Learn all about the oceans, sustainable fishing, plastic pollution, and how to protect our sea life!',
                                style: GoogleFonts.balooTamma2(
                                  fontSize: 16,
                                  color: Colors.white, // Dark color for text
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(color: Color(0xFF98BCE4)),
                          child: Column(
                            children: [
                              // Latest Articles Section
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Latest Articles',
                                      style: GoogleFonts.balooTamma2(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: darkBlue, // Extra dark color
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return ViewAllArticlesPage(); // Add const here if loginScreen has a const constructor
                                            },
                                          ),
                                        );
                                      },
                                      child: Text('View More'),
                                    ),
                                  ],
                                ),
                              ),

                              // Horizontal Scroll for Articles
                              Container(
                                height: 190,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sampleArticles.length < 3
                                      ? sampleArticles.length
                                      : 3, // Show only 3 articles
                                  itemBuilder: (context, index) {
                                    return _buildArticleCard(
                                        sampleArticles[index]);
                                  },
                                ),
                              ),
                              // Latest Videos Section
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12.0, 1, 12, 1),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Latest Videos',
                                      style: GoogleFonts.balooTamma2(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: darkBlue,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return EducationVideoPage(); // Add const here if loginScreen has a const constructor
                                            },
                                          ),
                                        );
                                        // Navigate to view more videos
                                      },
                                      child: Text('View More'),
                                    ),
                                  ],
                                ),
                              ),
                              // Horizontal Scroll for Videos
                              Container(
                                height: 190,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sampleVideos.length < 3
                                      ? sampleVideos.length
                                      : 3, // Show only 3 videos
                                  itemBuilder: (context, index) {
                                    return _buildVideoCard(sampleVideos[index]);
                                  },
                                ),
                              ),
                              SizedBox(height: 80),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build Article Card
  Widget _buildArticleCard(EducationArticle article) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 160,
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  article.imageUrls[0], // Article Image
                  height: 100,
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: GoogleFonts.balooTamma2(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(
                          Iconsax.eye_copy,
                          color: Color.fromARGB(255, 119, 144, 165),
                          size: 18,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '${article.viewCount}',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(width: 30),
                        Icon(
                          Iconsax.like_1_copy,
                          color: Color.fromARGB(255, 119, 144, 165),
                          size: 18,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '${article.likeCount} ',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build Video Card
  Widget _buildVideoCard(EducationVideo video) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.network(
                      video.thumbnailUrl, // Video Thumbnail
                      height: 100,
                      width: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 35,
                    left: 55,
                    child: Icon(FontAwesomeIcons.playCircle,
                        size: 40, color: Colors.white), // Play button icon
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: GoogleFonts.balooTamma2(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(
                          Iconsax.eye_copy,
                          color: Color.fromARGB(255, 119, 144, 165),
                          size: 18,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '${video.viewCount} ',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Iconsax.like_1_copy,
                          color: Color.fromARGB(255, 119, 144, 165),
                          size: 18,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '${video.likeCount} ',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show Upload Menu (Articles/Video)
  void _showUploadMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.article, color: Color(0xFFD4A373)),
              title: Text('Upload Article'),
              onTap: () {
                // Navigate to upload article screen
              },
            ),
            ListTile(
              leading: Icon(Icons.video_collection, color: Color(0xFFD4A373)),
              title: Text('Upload Video'),
              onTap: () {
                // Navigate to upload video screen
              },
            ),
          ],
        );
      },
    );
  }
}
