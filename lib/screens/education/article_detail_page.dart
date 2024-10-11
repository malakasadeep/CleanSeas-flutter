import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_seas_flutter/models/EducationArticle.dart';
import 'package:photo_view/photo_view.dart';

class ArticleDetailPage extends StatefulWidget {
  final EducationArticle article;

  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage>
    with TickerProviderStateMixin {
  bool isLiked = false;
  bool isFavorited = false;
  late ScrollController _scrollController;
  int likeCount = 0;
  String currentReaction = 'like';
  bool showReactions = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    likeCount = widget.article.likeCount;
    _loadLikeStatus();
    _scrollController = ScrollController();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadLikeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLiked = prefs.getBool(widget.article.id) ?? false;
      isFavorited = prefs.getBool('${widget.article.id}_fav') ?? false;
    });
  }

  Future<void> _toggleLike() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLiked = !isLiked;
      likeCount = isLiked ? likeCount + 1 : likeCount - 1;
      prefs.setBool(widget.article.id, isLiked);
    });
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorited = !isFavorited;
      prefs.setBool('${widget.article.id}_fav', isFavorited);
    });
  }

  void _shareArticle() {
    Share.share(
        '${widget.article.title}\n\n${widget.article.shortDescription}');
  }

  void _showImagePopup(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            child: PhotoView(
              imageProvider: NetworkImage(imageUrl),
              backgroundDecoration: BoxDecoration(color: Colors.transparent),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            ),
          ),
        );
      },
    );
  }

  void _toggleReactions() {
    setState(() {
      showReactions = !showReactions;
    });
    if (showReactions) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _selectReaction(String reaction) {
    setState(() {
      currentReaction = reaction;
      isLiked = true;
      showReactions = false;
    });
    _controller.reverse();
    _toggleLike();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        autoPlay: true,
                      ),
                      items: widget.article.imageUrls.map((imageUrl) {
                        return ClipRRect(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(30)),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        );
                      }).toList(),
                    ),
                    Positioned(
                      top: 40,
                      left: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.7),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Text(
                        widget.article.title,
                        style: GoogleFonts.balooTamma2(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(blurRadius: 3.0, color: Colors.black)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey.shade300,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(widget.article.authorAvatar),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                widget.article.author,
                                style: GoogleFonts.balooTamma2(fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Iconsax.eye, size: 18),
                              SizedBox(width: 4),
                              Text('${widget.article.viewCount}'),
                              SizedBox(width: 10),
                              IconButton(
                                icon: Icon(
                                  isFavorited
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorited ? Colors.red : null,
                                ),
                                onPressed: _toggleFavorite,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        widget.article.longDescription,
                        style: GoogleFonts.balooTamma2(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      ...widget.article.articleImages
                          .map((imageUrl) => Padding(
                                padding: EdgeInsets.only(bottom: 16),
                                child: GestureDetector(
                                  onTap: () => _showImagePopup(imageUrl),
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: child,
                    );
                  },
                  child: Visibility(
                    visible: showReactions,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildReactionButton(
                              'like', Iconsax.like_1, Colors.blue),
                          _buildReactionButton(
                              'love', Iconsax.heart, Colors.red),
                          _buildReactionButton(
                              'haha', Iconsax.happyemoji, Colors.yellow),
                          _buildReactionButton(
                              'wow', Iconsax.fatrows, Colors.yellow),
                          _buildReactionButton(
                              'sad', Iconsax.emoji_sad, Colors.yellow),
                          _buildReactionButton(
                              'angry', Iconsax.emoji_normal, Colors.orange),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFF98BCE4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: _toggleLike,
                        onLongPress: _toggleReactions,
                        child: _buildReactionIcon(
                          _getReactionIcon(),
                          _getReactionColor(),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Iconsax.message, color: Colors.white),
                        onPressed: () {
                          // Implement comment functionality
                        },
                      ),
                      IconButton(
                        icon: Icon(Iconsax.share, color: Colors.white),
                        onPressed: _shareArticle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReactionButton(String reaction, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => _selectReaction(reaction),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }

  Widget _buildReactionIcon(IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        SizedBox(width: 4),
        Text(
          _getReactionText(),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  IconData _getReactionIcon() {
    switch (currentReaction) {
      case 'like':
        return Iconsax.like_1;
      case 'love':
        return Iconsax.heart;
      case 'haha':
        return Iconsax.happyemoji;
      case 'wow':
        return Iconsax.fatrows;
      case 'sad':
        return Iconsax.emoji_sad;
      case 'angry':
        return Iconsax.emoji_normal;
      default:
        return isLiked ? Iconsax.like_1 : Iconsax.like_1_copy;
    }
  }

  Color _getReactionColor() {
    switch (currentReaction) {
      case 'like':
        return Colors.blue;
      case 'love':
        return Colors.red;
      case 'haha':
      case 'wow':
      case 'sad':
        return Colors.yellow;
      case 'angry':
        return Colors.orange;
      default:
        return isLiked ? Colors.blue : Colors.grey;
    }
  }

  String _getReactionText() {
    return currentReaction.capitalize();
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
