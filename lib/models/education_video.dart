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
    thumbnailUrl: 'https://i.ytimg.com/vi/7iwnC5x7-aA/hqdefault.jpg',
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
  EducationVideo(
    id: 'v003',
    title: 'Understanding Marine Ecosystems',
    thumbnailUrl: 'https://i.ytimg.com/vi/2dX4IUv-4Ko/hqdefault.jpg',
    videoUrl:
        'https://firebasestorage.googleapis.com/v0/b/cleanseas-flutter.appspot.com/o/education%2Fvideos%2FWhat%20Would%20Happen%20If%20All%20The%20Coral%20Reefs%20Died%20Off_2.mp4?alt=media&token=0630c532-32bb-48b7-98e0-0f4d81e9b179',
    description:
        'Dive deep into the world of marine ecosystems and discover how different species interact and thrive in the ocean.',
    viewCount: 4100,
    likeCount: 780,
    isTrending: true,
    isLatest: false,
    isMostViewed: true,
    author: 'Marine Ecologist',
    authorAvatarUrl:
        'https://www.padi.com/sites/default/files/styles/card_cover/public/images/2022-02/AlannahVellacottHeadshot%202.jpg?h=b0068e95&itok=kp3aDpJ-',
    uploadDate: DateTime(2023, 9, 10),
  ),
];
