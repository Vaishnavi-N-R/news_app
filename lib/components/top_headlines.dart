import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newsapp/constants/category.dart';
import 'package:newsapp/controllers/news_controller.dart';
import 'package:newsapp/widgets/article_card.dart';
import 'package:newsapp/constants/category.dart' as customCategory;
import 'package:newsapp/widgets/category_tile.dart';

class TopHeadlines extends StatefulWidget {
  @override
  _TopHeadlinesState createState() => _TopHeadlinesState();
}

class _TopHeadlinesState extends State<TopHeadlines> {
  final NewsController _newsController = Get.find();

  void _launchURL(BuildContext context, String url) async {
    final theme = Theme.of(context);
    try {
      await launchUrl(
        Uri.parse(url),
        customTabsOptions: CustomTabsOptions(
          colorSchemes: CustomTabsColorSchemes.defaults(
            toolbarColor: theme.colorScheme.surface,
            navigationBarColor: theme.colorScheme.surface,
          ),
          urlBarHidingEnabled: true,
          showTitle: true,
          browser: const CustomTabsBrowserConfiguration(
            prefersDefaultBrowser: true,
          ),
        ),
      );
    } catch (e) {
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
          child: Obx(() {
            var articles = _newsController.newsList;
            if (articles.isEmpty) {
              return const Center(
                child: Text('No categories available.'),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: Category.categorylist.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _newsController.category.value =
                            Category.categorylist[index]["name"]!;
                        _newsController
                            .fetchTopHeadlines(_newsController.category);
                      });
                    },
                    child: CategoryTile(
                        image: Category.categorylist[index]["image"],
                        categoryName: Category.categorylist[index]["name"]),
                  );
                });
          }),
        ),
        // News articles
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            child: Obx(() {
              if (_newsController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (_newsController.newsList.isEmpty) {
                return const Center(
                  child: Text('No articles found.'),
                );
              } else {
                return ListView.builder(
                  itemCount: _newsController.newsList.length,
                  itemBuilder: (ctx, index) {
                    var articles = _newsController.newsList;
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
      ],
    );
  }
}
