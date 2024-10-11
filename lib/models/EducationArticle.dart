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
  // Existing articles
  EducationArticle(
    id: '001',
    title: 'Sustainable Fishing Practices',
    imageUrls: [
      'https://www.intelligentliving.co/wp-content/uploads/2022/02/Sustainable_fish_farming.jpg',
      'https://oursharedseas.com/wp-content/uploads/2022/01/iStock-1336255025-800.jpg',
      'https://farandawayadventures.com/wp-content/uploads/2024/09/e5f21569thumbnail.jpeg',
    ],
    shortDescription:
        'Learn how sustainable fishing can help preserve ocean life.',
    longDescription:
        'Sustainable fishing aims to maintain fish populations and avoid overfishing... [additional content]',
    articleImages: [
      'https://cdn.shopify.com/s/files/1/0271/4642/0298/files/7835619.jpg?v=1679316969',
      'https://www.getculturedkitchen.com/wp-content/uploads/2017/06/Longline.jpg',
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
      'https://www.optimagutterprotection.com/wp-content/uploads/2022/06/plastic_01.jpg',
      'https://www.marinemammalcenter.org/storage/app/uploads/public/e3c/a8f/ff1/thumb__2400_0_0_0_auto.jpg',
      'https://www.kent.co.in/blog/wp-content/uploads/2018/06/Blog-image-1.jpg',
    ],
    shortDescription:
        'Plastic pollution is one of the largest threats to marine ecosystems.',
    longDescription:
        'Millions of tons of plastic waste end up in our oceans, causing... [additional content]',
    articleImages: [
      'https://live.staticflickr.com/65535/51649665394_b15c643f17_b.jpg',
      'https://images.squarespace-cdn.com/content/v1/5eda91260bbb7e7a4bf528d8/1625681653482-8SCINQYWKQRME6WY6JQF/Screenshot+2021-07-07+at+14-13-45+Macleod_et_al+2021+pdf.png',
    ],
    viewCount: 1520,
    likeCount: 340,
    isTrending: true,
    isLatest: true,
    isMostViewed: true,
    author: 'Oceanic Conservationist',
    publishDate: DateTime(2023, 9, 25),
  ),
  // New articles
  EducationArticle(
    id: '003',
    title: 'Coral Reefs: The Underwater Rainforests',
    imageUrls: [
      'https://www.theborneopost.com/newsimages/2015/04/C_PC0004961.jpg',
      'https://swimwithdolphinsandmantas.com/wp-content/uploads/2017/09/1491581693744-1024x768.jpeg',
      'https://strstudentnews.org/wp-content/uploads/2023/12/canva-MAEFhGZUGQk.jpg',
    ],
    shortDescription:
        'Discover the importance of coral reefs to marine biodiversity.',
    longDescription:
        'Coral reefs are vital to the health of the ocean, supporting... [additional content]',
    articleImages: [
      'https://images.encounteredu.com/excited-hare/production/uploads/activity-edible-polyp-figure-5.jpg?w=800&q=80&auto=format&fit=clip&dm=1631569804&s=ef8b74acaa047212371500af5d90871a',
      'https://cdn.coastalscience.noaa.gov/cdhc/2021/08/Coral-Polyp-Anatomy-Diagram.png',
    ],
    viewCount: 850,
    likeCount: 180,
    isTrending: true,
    isLatest: false,
    isMostViewed: false,
    author: 'Coral Reef Specialist',
    publishDate: DateTime(2023, 10, 10),
  ),
  EducationArticle(
    id: '004',
    title: 'Threaded Sea Creatures: Nature’s Engineers',
    imageUrls: [
      'https://www.nwf.org/-/media/NEW-WEBSITE/Shared-Folder/Magazines/2018/Dec-Jan/Vertical-Migration-DJ2018-3-900x591.jpg',
      'https://i.ytimg.com/vi/5NnOR3OyBbs/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLCkVLgx-bJsH1YRVBOhgrxXSYmOSg',
      'https://petapixel.com/assets/uploads/2020/01/ocean_feat.jpg',
    ],
    shortDescription:
        'Learn about the fascinating adaptations of threaded sea creatures.',
    longDescription:
        'Threaded sea creatures play a crucial role in maintaining... [additional content]',
    articleImages: [
      'https://onlinelibrary.wiley.com/cms/asset/1583686a-dad0-4bd6-a7ef-e945a6af5c2c/cbdv201900638-toc-0001-m.jpg',
      'https://i.pinimg.com/736x/d9/ca/35/d9ca35d0a1cd89b108e3f0b54d1cbb6f.jpg',
    ],
    viewCount: 620,
    likeCount: 140,
    isTrending: true,
    isLatest: true,
    isMostViewed: false,
    author: 'Marine Biologist',
    publishDate: DateTime(2023, 10, 1),
  ),
  EducationArticle(
    id: '005',
    title: 'කොරල් පර හා සම්බන්ධිත ජීවීන්ගේ ගුණාංග',
    imageUrls: [
      'https://media.istockphoto.com/id/508960998/photo/colorful-coral-reef-with-many-fishes.jpg?s=612x612&w=0&k=20&c=-GUHOS5N4fHr-uo1ROULLxceGOvI56hKwxa8Z2J4qR8=',
      'https://www.marineinsight.com/wp-content/uploads/2021/04/coral-reefs.jpg',
      'https://i.natgeofe.com/n/d326d61d-8ef6-4f4c-a03f-ab8fbbb40e6d/coral-reefs-2728211.jpg',
    ],
    shortDescription: 'කොරල් පර මත පදනම් වූ ජීවීන්ගේ ගුණාංග ඉගෙන ගන්න.',
    longDescription:
        'කොරල් පර සමඟ සම්බන්ධිත ජීවීන්ගේ පරිසරය සහ වැදගත්කම... [additional content]',
    articleImages: [
      'https://example.com/coral_sinhala_article1.jpg',
      'https://example.com/coral_sinhala_article2.jpg',
    ],
    viewCount: 430,
    likeCount: 95,
    isTrending: true,
    isLatest: true,
    isMostViewed: false,
    author: 'ජල විද්‍යාඥයා',
    publishDate: DateTime(2023, 10, 7),
  ),
];
