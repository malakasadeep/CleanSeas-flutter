// view_all_articles_page.dart
import 'package:clean_seas_flutter/screens/education/article_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:clean_seas_flutter/models/EducationArticle.dart'; // Import your model

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

  // Function to filter articles based on search query
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF98BCE4),
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
  Widget _buildArticleList(List<EducationArticle> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticleCard(article: articles[index]);
      },
    );
  }
}
