// article_card.dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_seas_flutter/screens/education/article_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:clean_seas_flutter/models/EducationArticle.dart'; // Import your model

class ArticleCard extends StatelessWidget {
  final EducationArticle article;

  const ArticleCard({required this.article});

  // Function to calculate time difference between today and publish date
  String calculateTimeAgo(DateTime publishDate) {
    final currentDate = DateTime.now();
    final difference = currentDate.difference(publishDate).inDays;
    return difference == 0 ? 'Today' : '$difference days ago';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailPage(article: article),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Slider
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                ),
                items: article.imageUrls.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          child: Icon(Icons.error, color: Colors.red),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            // Article Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: GoogleFonts.balooTamma2(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    article.shortDescription,
                    style: GoogleFonts.balooTamma2(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Iconsax.eye_copy, size: 16, color: Colors.blue),
                          SizedBox(width: 4),
                          Text(
                            '${article.viewCount}',
                            style: TextStyle(color: Colors.blue),
                          ),
                          SizedBox(width: 16),
                          Icon(Iconsax.like_1_copy,
                              size: 16, color: Colors.red),
                          SizedBox(width: 4),
                          Text(
                            '${article.likeCount}',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      Text(
                        calculateTimeAgo(article.publishDate),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Action Buttons
          ],
        ),
      ),
    );
  }
}
