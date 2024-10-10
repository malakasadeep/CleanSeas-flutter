class EducationArticle {
  final String id;
  final String title;
  final List<String> imageUrls; // 3 images in array
  final String shortDescription;
  final String longDescription;
  final List<String> articleImages; // Additional images in the article
  final int viewCount;
  final int likeCount;
  final bool isTrending;
  final bool isLatest;
  final bool isMostViewed;
  final String author;
  final DateTime publishDate;

  EducationArticle({
    required this.id,
    required this.title,
    required this.imageUrls,
    required this.shortDescription,
    required this.longDescription,
    required this.articleImages,
    required this.viewCount,
    required this.likeCount,
    required this.isTrending,
    required this.isLatest,
    required this.isMostViewed,
    required this.author,
    required this.publishDate,
  });
}

List<EducationArticle> sampleArticles = [
  EducationArticle(
    id: '001',
    title: 'Sustainable Fishing Practices',
    imageUrls: [
      'https://imageio.forbes.com/specials-images/imageserve/6669d614535331aa01194100/Tropical-fish-and-turtle/960x0.jpg?height=472&width=711&fit=bounds',
      'https://example.com/image2.jpg',
      'https://example.com/image3.jpg',
    ],
    shortDescription:
        'Learn how sustainable fishing can help preserve ocean life.',
    longDescription:
        'Sustainable fishing aims to maintain fish populations and avoid overfishing... [additional content]',
    articleImages: [
      'https://example.com/article_image1.jpg',
      'https://example.com/article_image2.jpg',
    ],
    viewCount: 1024,
    likeCount: 250,
    isTrending: true,
    isLatest: false,
    isMostViewed: false,
    author: 'Marine Expert',
    publishDate: DateTime(2023, 10, 5),
  ),
  EducationArticle(
    id: '002',
    title: 'Impact of Plastic Pollution on Marine Life',
    imageUrls: [
      'https://imageio.forbes.com/specials-images/imageserve/6669d614535331aa01194100/Tropical-fish-and-turtle/960x0.jpg?height=472&width=711&fit=bounds',
      'https://example.com/plastic2.jpg',
      'https://example.com/plastic3.jpg',
    ],
    shortDescription:
        'Plastic pollution is one of the largest threats to marine ecosystems.',
    longDescription:
        'Millions of tons of plastic waste end up in our oceans, causing... [additional content]',
    articleImages: [
      'https://example.com/article_image3.jpg',
      'https://example.com/article_image4.jpg',
    ],
    viewCount: 1520,
    likeCount: 340,
    isTrending: false,
    isLatest: true,
    isMostViewed: true,
    author: 'Oceanic Conservationist',
    publishDate: DateTime(2023, 9, 25),
  ),
];
