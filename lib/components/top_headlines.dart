import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart'; // Make sure you have this package
import 'package:get/get.dart';
import 'package:newsapp/controllers/news_controller.dart';
import 'package:newsapp/constants/category.dart' as customCategory;
import 'package:newsapp/widgets/article_card.dart';
import 'package:newsapp/widgets/category_tile.dart';

class TopHeadlines extends StatefulWidget {
  @override
  _TopHeadlinesState createState() => _TopHeadlinesState();
}

class _TopHeadlinesState extends State<TopHeadlines> {
  final NewsController _newsController = Get.find();

  // Updated _launchURL method
  void _launchURL(BuildContext context, String url) async {
    final theme = Theme.of(context); // Fetch the current theme
    try {
      await launchUrl(
        Uri.parse(url), // Use Uri.parse to parse the URL
        customTabsOptions: CustomTabsOptions(
          colorSchemes: CustomTabsColorSchemes.defaults(
            toolbarColor: theme.colorScheme.surface, // Set toolbar color
            navigationBarColor:
                theme.colorScheme.surface, // Set navigation bar color
          ),
          urlBarHidingEnabled: true,
          showTitle: true,
          browser: const CustomTabsBrowserConfiguration(
            prefersDefaultBrowser: true, // Prefer the default browser
          ),
        ),
      );
    } catch (e) {
      // Handle the exception in case the browser app is not available
      debugPrint('Error launching custom tab: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Horizontal list of categories
        Container(
          width: double.infinity,
          height: 100,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: customCategory.Category.categorylist.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                var articles = _newsController.newsList;
                print('Article ${index}: ${articles[index].title}');

                // Check if the urlToImage is null and provide a default image if necessary
                final imageUrl = articles[index].urlToImage ??
                    'https://via.placeholder.com/150';

                return InkWell(
                  onTap: () => _launchURL(context, articles[index].url),
                  child: ArticleCard(
                    imageUrl: imageUrl, // Pass the safe imageUrl
                    title: articles[index].title,
                    source: articles[index].source.name,
                    publishedAt: articles[index].publishedAt,
                  ),
                );
              }),
        ),
        // News articles
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
              child: Obx(() {
                print('Loading state: ${_newsController.isLoading.value}');
                if (_newsController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  print(
                      'Number of articles: ${_newsController.newsList.length}');
                  if (_newsController.newsList.isEmpty) {
                    return const Center(child: Text('No articles found.'));
                  }
                  return ListView.builder(
                    itemCount: _newsController.newsList.length,
                    itemBuilder: (ctx, index) {
                      var articles = _newsController.newsList;
                      print('Article ${index}: ${articles[index].title}');
                      return InkWell(
                        onTap: () => _launchURL(context, articles[index].url),
                        child: ArticleCard(
                          imageUrl: articles[index].urlToImage,
                          title: articles[index].title,
                          source: articles[index].source.name,
                          publishedAt: articles[index].publishedAt,
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ),
        ),
      ],
    );
  }
}
