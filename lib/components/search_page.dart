
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:get/get.dart';
import 'package:newsapp/controllers/news_controller.dart';
import 'package:newsapp/widgets/article_card.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final NewsController _newsController = Get.find();

  final TextEditingController _filter = new TextEditingController();

  String searchText = "";

  @override
  void initState() {
    _filter.addListener(() {
      _filter.text;
    });
    super.initState();
  }

  @override
  void dispose() {
    _filter.dispose();

    super.dispose();
  }

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
    // Handle the exception if the browser app is not installed or other errors.
    debugPrint(e.toString());
  }
}


  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                    blurRadius: 1, spreadRadius: 2, color: Colors.grey.shade300)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextField(
                      onChanged: (value) {
                        searchText = value;
                      },
                      controller: _filter,
                      cursorHeight: 20,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Search"),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _newsController.query.value = searchText;
                        _newsController
                            .fetchResultsforQuery(_newsController.query);
                      });
                    },
                    icon: Icon(Icons.search))
              ],
            ),
          ),
        ),
        Obx(() {
          if (_newsController.isResultsForQueryLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (_newsController.query.value == "") {
            return Center(
              child: Text("Nothing to show"),
            );
          } else
            return Expanded(
              child: ListView.builder(
                  itemCount: _newsController.articleListForQuery.length,
                  itemBuilder: (ctx, index) {
                    var articles = _newsController.articleListForQuery;
                    return InkWell(
                      onTap: () => _launchURL(context, articles[index].url),
                      child: ArticleCard(
                          imageUrl: articles[index].urlToImage,
                          title: articles[index].title,
                          source: articles[index].source.name,
                          publishedAt: articles[index].publishedAt),
                    );
                  }),
            );
        })
      ],
    ));
  }
}