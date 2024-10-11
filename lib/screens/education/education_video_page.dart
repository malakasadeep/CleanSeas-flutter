import 'package:clean_seas_flutter/models/education_video.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EducationVideoPage extends StatefulWidget {
  @override
  _EducationVideoPageState createState() => _EducationVideoPageState();
}

class _EducationVideoPageState extends State<EducationVideoPage> {
  final TextEditingController _searchController = TextEditingController();
  List<EducationVideo> filteredVideos = List.from(sampleVideos);
  bool _isLoading = false; // Loading state
  bool _hasError = false; // Error state

  void _filterVideos(String query) {
    setState(() {
      _isLoading = true;
      filteredVideos = sampleVideos
          .where((video) =>
              video.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF98BCE4),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 2.0),
              child: Column(
                children: [
                  Row(
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
                      SizedBox(width: 20),
                      Text(
                        'All Education Videos',
                        style: GoogleFonts.balooTamma2(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search videos...',
                  prefixIcon:
                      Icon(FontAwesomeIcons.search, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: _filterVideos,
              ),
            ),
            Expanded(
              child: _isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator(), // Show loading spinner
                    )
                  : _hasError
                      ? Center(
                          child: Text(
                            'Error loading videos. Please try again.',
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredVideos.length,
                          itemBuilder: (context, index) {
                            return VideoCard(video: filteredVideos[index]);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoCard extends StatefulWidget {
  final EducationVideo video;

  VideoCard({required this.video});

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  bool _isExpanded = false;
  bool _isPlaying = false;
  bool _isLoadingVideo = true; // Video loading state
  bool _hasVideoError = false; // Video error state
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _videoPlayerController =
        VideoPlayerController.network(widget.video.videoUrl);

    _videoPlayerController.initialize().then((_) {
      setState(() {
        _isLoadingVideo = false; // Loading complete
      });
    }).catchError((error) {
      // Handle error and show alert
      setState(() {
        _isLoadingVideo = false;
        _hasVideoError = true;
      });
      _showErrorDialog('Failed to load video.');
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: _isPlaying
                    ? AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Chewie(controller: _chewieController!),
                      )
                    : _isLoadingVideo
                        ? Container(
                            height: 200,
                            child: Center(
                              child:
                                  CircularProgressIndicator(), // Show video loading spinner
                            ),
                          )
                        : _hasVideoError
                            ? Container(
                                height: 200,
                                child: Center(
                                  child: Text(
                                    'Failed to load video',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : Image.network(
                                widget.video.thumbnailUrl,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
              ),
              if (!_isPlaying && !_isLoadingVideo && !_hasVideoError)
                IconButton(
                  icon: Icon(FontAwesomeIcons.playCircle,
                      size: 50, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _isPlaying = true;
                      _chewieController = ChewieController(
                        videoPlayerController: _videoPlayerController,
                        autoPlay: true,
                        looping: false,
                      );
                    });
                  },
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.video.authorAvatarUrl),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.video.title,
                        style: GoogleFonts.balooTamma2(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${widget.video.author} • ${widget.video.viewCount} views • ${DateFormat.yMMMd().format(widget.video.uploadDate)}',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconButton(
                  FontAwesomeIcons.thumbsUp,
                  '${widget.video.likeCount}',
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Liked')),
                    );
                  },
                ),
                _buildIconButton(
                  FontAwesomeIcons.share,
                  'Share',
                  () {
                    Share.share('Check out this video: ${widget.video.title}');
                  },
                ),
                _buildIconButton(
                  FontAwesomeIcons.heart,
                  'Wishlist',
                  () {
                    // Implement wishlist functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added to wishlist')),
                    );
                  },
                ),
                TextButton(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        _isExpanded
                            ? FontAwesomeIcons.chevronUp
                            : FontAwesomeIcons.chevronDown,
                        color: Colors.white,
                        size: 16, // Adjust size as needed
                      ),
                      SizedBox(height: 2),
                      Text(
                        _isExpanded ? 'Show Less' : 'Show More',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
              ],
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                widget.video.description,
                style: TextStyle(color: Colors.white70),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            FaIcon(icon, color: Colors.white, size: 20),
            SizedBox(height: 4),
            Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
