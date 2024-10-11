class EducationVideo {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String videoUrl;
  final String description;
  final int viewCount;
  late final int likeCount;
  final bool isTrending;
  final bool isLatest;
  final bool isMostViewed;
  final String author;
  final String authorAvatarUrl;
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
    required this.authorAvatarUrl,
    required this.uploadDate,
  });
}

List<EducationVideo> sampleVideos = [
  EducationVideo(
    id: 'v001',
    title: 'The Hidden Secrets of the Ocean',
    thumbnailUrl: 'https://i.ytimg.com/vi/_5DooxgwEiw/hqdefault.jpg',
    videoUrl:
        'https://firebasestorage.googleapis.com/v0/b/cleanseas-flutter.appspot.com/o/education%2Fvideos%2FWhat%20Would%20Happen%20If%20All%20The%20Coral%20Reefs%20Died%20Off_2.mp4?alt=media&token=0630c532-32bb-48b7-98e0-0f4d81e9b179',
    description:
        'Explore the wonders of the ocean and learn about its hidden secrets.',
    viewCount: 3450,
    likeCount: 560,
    isTrending: true,
    isLatest: false,
    isMostViewed: true,
    author: 'Ocean Explorer',
    authorAvatarUrl:
        'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
    uploadDate: DateTime(2023, 8, 18),
  ),
  EducationVideo(
    id: 'v002',
    title: 'How to Combat Plastic Pollution',
    thumbnailUrl:
        'https://imageio.forbes.com/specials-images/imageserve/6669d614535331aa01194100/Tropical-fish-and-turtle/960x0.jpg?height=472&width=711&fit=bounds',
    videoUrl:
        'https://firebasestorage.googleapis.com/v0/b/cleanseas-flutter.appspot.com/o/education%2Fvideos%2FWhat%20Would%20Happen%20If%20All%20The%20Coral%20Reefs%20Died%20Off_2.mp4?alt=media&token=0630c532-32bb-48b7-98e0-0f4d81e9b179',
    description:
        'Learn practical steps to reduce plastic pollution in the ocean.',
    viewCount: 2890,
    likeCount: 420,
    isTrending: false,
    isLatest: true,
    isMostViewed: false,
    author: 'Environmental Activist',
    authorAvatarUrl:
        'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
    uploadDate: DateTime(2023, 10, 2),
  ),
];
