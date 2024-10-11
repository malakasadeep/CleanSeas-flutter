import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:share_plus/share_plus.dart'; // For sharing
import 'package:shared_preferences/shared_preferences.dart'; // For storing like status
import 'package:clean_seas_flutter/models/EducationArticle.dart';

class ArticleDetailPage extends StatefulWidget {
  final EducationArticle article;

  const ArticleDetailPage({required this.article});

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  bool isLiked = false;
  bool isFavorited = false;
  bool isCommentSectionVisible = true;
  late ScrollController _scrollController;
  int likeCount = 0;

  @override
  void initState() {
    super.initState();
    likeCount = widget.article.likeCount;
    _loadLikeStatus();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          isCommentSectionVisible = false; // Hide comment section on scroll
        });
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          isCommentSectionVisible =
              true; // Show comment section when not scrolling
        });
      }
    });
  }

  // Load the like status from shared preferences
  Future<void> _loadLikeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLiked = prefs.getBool(widget.article.id) ?? false;
    });
  }

  // Toggle like status and save it in shared preferences
  Future<void> _toggleLike() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLiked = !isLiked;
      likeCount = isLiked ? likeCount + 1 : likeCount - 1;
      prefs.setBool(widget.article.id, isLiked);
    });
  }

  // Share article content
  void _shareArticle() {
    Share.share(
        '${widget.article.title}\n\n${widget.article.shortDescription}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Details', style: GoogleFonts.balooTamma2()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image slider at the top
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    autoPlay: true,
                  ),
                  items: widget.article.imageUrls.map((imageUrl) {
                    return Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  }).toList(),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Article Title
                      Text(
                        widget.article.title,
                        style: GoogleFonts.balooTamma2(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Author Section with Avatar
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.article.author,
                            style: GoogleFonts.balooTamma2(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Long Description
                      Text(
                        widget.article.longDescription,
                        style: GoogleFonts.balooTamma2(fontSize: 16),
                      ),

                      const SizedBox(height: 16),

                      // Article Images 2x1
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemCount: widget.article.articleImages.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            widget.article.articleImages[index],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      const SizedBox(height: 16),

                      // Views and Likes section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Iconsax.eye, color: Colors.blue),
                              const SizedBox(width: 4),
                              Text('${widget.article.viewCount} Views'),
                            ],
                          ),
                          GestureDetector(
                            onLongPress: () {
                              _showReactionDialog(); // Show reactions on long press
                            },
                            child: Row(
                              children: [
                                Icon(
                                  isLiked
                                      ? Iconsax.like_1
                                      : Iconsax.like_1_copy,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 4),
                                Text('$likeCount Likes'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Share and Favorite buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            icon: Icon(Iconsax.heart),
                            label:
                                Text(isFavorited ? 'Unfavorite' : 'Favorite'),
                            onPressed: () {
                              setState(() {
                                isFavorited = !isFavorited;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isFavorited ? Colors.red : Colors.grey,
                            ),
                          ),
                          ElevatedButton.icon(
                            icon: Icon(Iconsax.share),
                            label: Text('Share'),
                            onPressed: _shareArticle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Comment Section (shows/hides based on scroll)
          if (isCommentSectionVisible)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Comments Section: Add comments here...',
                  style: GoogleFonts.balooTamma2(fontSize: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Show reactions dialog for long press
  void _showReactionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('React to the article'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Iconsax.like_1, color: Colors.blue),
              Icon(Iconsax.heart, color: Colors.red),
              Icon(Iconsax.smileys, color: Colors.yellow),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
