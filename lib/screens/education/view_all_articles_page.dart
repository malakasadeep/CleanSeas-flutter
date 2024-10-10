import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:clean_seas_flutter/models/EducationArticle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart'; // For formatting dates
import 'package:share_plus/share_plus.dart'; // For sharing functionality

class ViewAllArticlesPage extends StatefulWidget {
  @override
  _ViewAllArticlesPageState createState() => _ViewAllArticlesPageState();
}

class _ViewAllArticlesPageState extends State<ViewAllArticlesPage>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  bool showSearch = false; // Toggle search bar
  late TabController _tabController;

  List<EducationArticle> filteredArticles = sampleArticles;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  // Function to calculate time difference between today and publish date
  String calculateTimeAgo(DateTime publishDate) {
    final currentDate = DateTime.now();
    final difference = currentDate.difference(publishDate).inDays;
    return difference == 0 ? 'Today' : '$difference days ago';
  }

  // Live search function
  void _filterArticles(String query) {
    setState(() {
      filteredArticles = sampleArticles
          .where((article) =>
              article.title.toLowerCase().contains(query.toLowerCase()) ||
              article.shortDescription
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  // Function to share article content
  void _shareArticle(EducationArticle article) {
    Share.share('${article.title} - ${article.shortDescription}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlue,
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.fromLTRB(20, 40, 20, 0), // Top padding of 40
            child: Row(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context); // Back navigation
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(Iconsax.arrow_circle_left,
                      color: Colors.black),
                ),
                const SizedBox(width: 20),
                if (showSearch)
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        _filterArticles(
                            value); // Filter articles as the user types
                      },
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Search articles...',
                        border: InputBorder.none,
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Text(
                      'All Articles',
                      style: GoogleFonts.balooTamma2(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                IconButton(
                  icon: Icon(showSearch
                      ? Iconsax.close_circle_copy
                      : Iconsax.search_normal_copy),
                  onPressed: () {
                    setState(() {
                      showSearch = !showSearch;
                      if (!showSearch) {
                        searchController.clear();
                        _filterArticles('');
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.black,
            tabs: const [
              Tab(text: 'Trending'),
              Tab(text: 'Latest'),
              Tab(text: 'Most Viewed'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildArticleList(_filterArticlesByCategory('trending')),
                _buildArticleList(_filterArticlesByCategory('latest')),
                _buildArticleList(_filterArticlesByCategory('mostViewed')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to filter articles based on the tab category
  List<EducationArticle> _filterArticlesByCategory(String category) {
    List<EducationArticle> filtered = [];
    if (category == 'trending') {
      filtered =
          filteredArticles.where((article) => article.isTrending).toList();
    } else if (category == 'latest') {
      filtered = filteredArticles.where((article) => article.isLatest).toList();
    } else if (category == 'mostViewed') {
      filtered =
          filteredArticles.where((article) => article.isMostViewed).toList();
    }
    return filtered;
  }

  // Build the list of article cards
// Build the list of article cards
  Widget _buildArticleList(List<EducationArticle> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
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
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
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
                              Icon(Iconsax.eye_copy,
                                  size: 16, color: Colors.blue),
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.favorite_border, size: 18),
                        label: Text('Wishlist'),
                        onPressed: () {
                          // Add to wishlist functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red,
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.share, size: 18),
                        label: Text('Share'),
                        onPressed: () => _shareArticle(article),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ArticleDetailPage extends StatelessWidget {
  final EducationArticle article;

  const ArticleDetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(article.imageUrls[0]),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                article.longDescription,
                style: GoogleFonts.balooTamma2(fontSize: 16),
              ),
            ),
            // Display additional article images
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: article.articleImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.network(article.articleImages[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Article Detail Page
