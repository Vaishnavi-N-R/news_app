import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/services/remote_services.dart';

class NewsController extends GetxController {
  var newsList = [].obs;
  var articleListForQuery = [].obs;
  var sourceList = [].obs;
  var isLoading = true.obs;
  var isSourcesLoading = true.obs;
  var isResultsForQueryLoading = true.obs;
  var category = "general".obs;
  var pos = 0.obs;
  var query = "".obs;

  @override
  void onInit() {
    fetchTopHeadlines(category);
    fetchSources();
    fetchResultsforQuery(query);

    super.onInit();
  }

  void fetchTopHeadlines(RxString category) async {
    try {
      isLoading(true);

      // Fetch the articles from your API
      var articles = await RemoteServices.fetchTopHeadlines(category.string);

      if (articles != null) {
        // Ensure that each article has all the necessary properties
        articles = articles.where((article) {
          // Check for null values and provide default values where necessary
          return article.title != null &&
              article.url != null &&
              article.description != null &&
              article.urlToImage != null;
        }).toList();

        // Assign the filtered articles to the list
        newsList.assignAll(articles);
      }
    } catch (e) {
      print('Error fetching top headlines: $e');
    } finally {
      isLoading(false);
    }
  }

  void fetchSources() async {
    try {
      isSourcesLoading(true);
      var sources = await RemoteServices.fetchSources();
      if (sources != null) {
        sourceList.assignAll(sources);
      }
    } catch (e) {
    } finally {
      isSourcesLoading(false);
    }
  }

  void fetchResultsforQuery(RxString query) async {
    try {
      isResultsForQueryLoading(true);
      var results = await RemoteServices.fetchResultsForQuery(query.string);
      if (results != null) {
        articleListForQuery.assignAll(results);
      }
    } catch (e) {
    } finally {
      isResultsForQueryLoading(false);
    }
  }
}
