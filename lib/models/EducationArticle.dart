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
  final String authorAvatar; // New attribute for author avatar
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
    required this.authorAvatar, // Set this in constructor
    required this.publishDate,
  });
}

List<EducationArticle> sampleArticles = [
  EducationArticle(
    id: '001',
    title: 'Sustainable Fishing Practices',
    imageUrls: [
      'https://www.intelligentliving.co/wp-content/uploads/2022/02/Sustainable_fish_farming.jpg',
      'https://oursharedseas.com/wp-content/uploads/2022/01/iStock-1336255025-800.jpg',
      'https://farandawayadventures.com/wp-content/uploads/2024/09/e5f21569thumbnail.jpeg',
    ],
    shortDescription:
        'Learn how sustainable fishing can help preserve ocean life by managing fish populations effectively while avoiding overfishing and damage to marine ecosystems.',
    longDescription:
        'Learn how sustainable fishing can help preserve ocean life by managing fish populations effectively while avoiding overfishing and damage to marine ecosystems. Sustainable fishing aims to maintain fish populations over time, ensuring that we can continue to fish responsibly while minimizing harm to aquatic ecosystems. Techniques like selective fishing gear and controlled quotas are being implemented to balance human demand with marine conservation efforts. Discover key methods used today and the challenges still faced in this field.',
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
    authorAvatar:
        'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
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
        'Explore how plastic pollution has become one of the most dangerous threats to marine life, affecting species large and small across our oceans.',
    longDescription:
        'Explore how plastic pollution has become one of the most dangerous threats to marine life, affecting species large and small across our oceans.Plastic waste, from tiny microplastics to large debris, is a growing concern in marine ecosystems. Every year, millions of tons of plastic waste enter our oceans, harming marine life through entanglement, ingestion, and habitat destruction. Learn more about the sources of plastic pollution and the global efforts to mitigate its impact on marine species and environments.',
    articleImages: [
      'https://rethinksustainability.ca/wp-content/uploads/2019/08/article_ocean.jpg',
      'https://images.squarespace-cdn.com/content/v1/5eda91260bbb7e7a4bf528d8/1625681653482-8SCINQYWKQRME6WY6JQF/Screenshot+2021-07-07+at+14-13-45+Macleod_et_al+2021+pdf.png',
    ],
    viewCount: 1520,
    likeCount: 340,
    isTrending: true,
    isLatest: true,
    isMostViewed: true,
    author: 'Oceanic Conservationist',
    authorAvatar:
        'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
    publishDate: DateTime(2023, 9, 25),
  ),
  EducationArticle(
    id: '003',
    title: 'Coral Reefs: The Underwater Rainforests',
    imageUrls: [
      'https://www.theborneopost.com/newsimages/2015/04/C_PC0004961.jpg',
      'https://swimwithdolphinsandmantas.com/wp-content/uploads/2017/09/1491581693744-1024x768.jpeg',
      'https://strstudentnews.org/wp-content/uploads/2023/12/canva-MAEFhGZUGQk.jpg',
    ],
    shortDescription:
        'Dive into the world of coral reefs, often referred to as the rainforests of the sea, and their critical role in supporting marine biodiversity.',
    longDescription:
        'Dive into the world of coral reefs, often referred to as the rainforests of the sea, and their critical role in supporting marine biodiversity.Coral reefs provide a habitat for a diverse range of marine species, offering food, shelter, and breeding grounds for countless organisms. Despite their importance, these ecosystems are under threat from climate change, pollution, and destructive fishing practices. This article explores the unique structure of coral reefs, their ecological significance, and the urgent need for their protection.',
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
    authorAvatar:
        'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
    publishDate: DateTime(2023, 10, 10),
  ),
  EducationArticle(
    id: '004',
    title: 'Threaded Sea Creatures: Nature’s Engineers',
    imageUrls: [
      'https://images.playground.com/92d6495b038c46c1a28701bb3762037c.jpeg',
      'https://i.ytimg.com/vi/5NnOR3OyBbs/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLCkVLgx-bJsH1YRVBOhgrxXSYmOSg',
      'https://petapixel.com/assets/uploads/2020/01/ocean_feat.jpg',
    ],
    shortDescription:
        'Uncover the engineering marvels of sea creatures that use threads to build structures, capture prey, and defend themselves in underwater habitats.',
    longDescription:
        'Uncover the engineering marvels of sea creatures that use threads to build structures, capture prey, and defend themselves in underwater habitats.Threaded sea creatures such as mollusks, certain worms, and even some fish species have developed fascinating biological adaptations that allow them to spin threads or fibers to trap food, build habitats, or evade predators. This article highlights these unique species and the ecological significance of their behaviors in maintaining marine biodiversity.',
    articleImages: [
      'https://rethinksustainability.ca/wp-content/uploads/2019/08/article_ocean.jpg',
      'https://i.pinimg.com/736x/d9/ca/35/d9ca35d0a1cd89b108e3f0b54d1cbb6f.jpg',
    ],
    viewCount: 620,
    likeCount: 140,
    isTrending: true,
    isLatest: true,
    isMostViewed: false,
    author: 'Marine Biologist',
    authorAvatar:
        'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
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
        'කොරල් පර මත පදනම් වූ ජීවීන්ගේ පරිසරය, කටයුතු සහ ඉතිහාසය ඉගෙන ගන්න. මෙවැනි ජීවීන් සාමාන්‍යයෙන් ජල පරිසරවල ජීවත් වන අතර ඔවුන්ගේ විවිධ ගුණාංගය පරිසර සම්පතක ලෙස වැදගත්කමක් ඇති අතර, පරිසරය තුළ ඇති විවිධත්වය රඳා පවතී.කොරල් පර යනු නොගැඹුරු නිවර්ථන පෝෂක පදාර්ථ ඉතා සුළු ප්‍රමාණයක් හෝ පෝෂ ද්‍රව්‍ය‍ නොමැති සමුද්‍ර ජලයෙහි අන්තර්ගත ජීවි විශේෂ වලින් නිෂ්පාදනය කරනු ලබන ඇරගනයිට් ව්‍යුහයන් වේ. කාෂිකාර්මික ප්‍රදේශ වලින් නිකුත් කරනු ලබන අධි පෝෂණය සහිත සංඝටක නිසා ඇල්ගි වල වර්ධනය දිරිමත් කිරීම මගින් මෙකී කොරල් පර වලට හානි සිදුවිය හැකිය. බොහෝ කොරල් පර වල ප්‍රමුඛතම ජීවි විශේෂයන් වනුයේ පාෂාණමය කොරල්ය. මේවා කැල්සියම් කාබනේට් බහිස්සැකිලි ස්‍රාවය කරන ගනාවාසයේ නිඩේරියාවන්ගෙන් සැදී ඇත. මෙලෙස සැකිලි ද්‍රව්‍ය එක්රැස්වීමෙන් සහ කැඩිබිදි ඒවා සාගර තරංග මගින් එකිනෙක මත ගොඩ ගැසි ජෛව විඛාදනයට පත් වීමෙන් සුවිශාල කැල්සියම් වලින් සැදුම්ලත් ගනාවාස බිහිවන අතර ඒවා මගින් අනෙකුත් ජීවි කොරල් වලට සහ විශේෂ මාදලි වල වෙනත් ශාක හා සත්ව ජීවිත වලට ආධාර සපයනු ලැබේ. මේකි කොරල් නිවර්තන සහ සෞම්‍ය ජලයෙහි දක්නට ලැබුණද කොරල් පර සෑදෙනුයේ සමකයෙහි සිට අක්ෂාංශ 30 කත් සහ දේෂාංශ 30 ක් අතර කලාපයේදීය. කොරල් ඉතා කුඩා ජීවියෙකුගේ නිර්මාණයකි.මේ කුඩා ජීවියා "පොලිප් ජීවියා" හෙවත් බුහුබාවා ලෙස හදුන්වයි.',
    articleImages: [
      'https://images.encounteredu.com/excited-hare/production/uploads/activity-edible-polyp-figure-5.jpg?w=800&q=80&auto=format&fit=clip&dm=1631569804&s=ef8b74acaa047212371500af5d90871a',
      'https://cdn.coastalscience.noaa.gov/cdhc/2021/08/Coral-Polyp-Anatomy-Diagram.png',
    ],
    viewCount: 430,
    likeCount: 95,
    isTrending: true,
    isLatest: true,
    isMostViewed: false,
    author: 'මහින්ද රාජපක්ෂ',
    authorAvatar:
        'https://pbs.twimg.com/profile_images/541867053351583744/rcxem8NU_400x400.jpeg',
    publishDate: DateTime(2023, 10, 7),
  ),
];
