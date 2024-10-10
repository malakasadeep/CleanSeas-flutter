class EducationVideo {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String videoUrl;
  final String description;
  final int viewCount;
  final int likeCount;
  final bool isTrending;
  final bool isLatest;
  final bool isMostViewed;
  final String author;
  final DateTime uploadDate;

  EducationVideo({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.description,
    required this.viewCount,
    required this.likeCount,
    required this.isTrending,
    required this.isLatest,
    required this.isMostViewed,
    required this.author,
    required this.uploadDate,
  });
}

List<EducationVideo> sampleVideos = [
  EducationVideo(
    id: 'v001',
    title: 'The Hidden Secrets of the Ocean',
    thumbnailUrl:
        'https://imageio.forbes.com/specials-images/imageserve/6669d614535331aa01194100/Tropical-fish-and-turtle/960x0.jpg?height=472&width=711&fit=bounds',
    videoUrl: 'https://example.com/video1.mp4',
    description:
        'Explore the wonders of the ocean and learn about its hidden secrets.',
    viewCount: 3450,
    likeCount: 560,
    isTrending: true,
    isLatest: false,
    isMostViewed: true,
    author: 'Ocean Explorer',
    uploadDate: DateTime(2023, 8, 18),
  ),
  EducationVideo(
    id: 'v002',
    title: 'How to Combat Plastic Pollution',
    thumbnailUrl:
        'https://imageio.forbes.com/specials-images/imageserve/6669d614535331aa01194100/Tropical-fish-and-turtle/960x0.jpg?height=472&width=711&fit=bounds',
    videoUrl: 'https://example.com/video2.mp4',
    description:
        'Learn practical steps to reduce plastic pollution in the ocean.',
    viewCount: 2890,
    likeCount: 420,
    isTrending: false,
    isLatest: true,
    isMostViewed: false,
    author: 'Environmental Activist',
    uploadDate: DateTime(2023, 10, 2),
  ),
];
