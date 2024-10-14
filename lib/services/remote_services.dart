import 'dart:convert';
import 'package:newsapp/components/sources.dart' as sourcesComponent;
import 'package:newsapp/constants/data.dart';
import 'package:newsapp/models/news_response.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/source_response.dart' as sourcesModel;

class RemoteServices {
  static var client = http.Client();

  static Future<List<Articles>?> fetchTopHeadlines(String category) async {
    var url =
        '${Data.BASE_URL}/v2/top-headlines?country=us&category=$category&apiKey=${Data.API}';
    var response = await client.get(Uri.parse(url));
    print("Response for topheadlines:${response.body}");

    if (response.statusCode == 200) {
      var jsonString = response.body;
      print("Response:$jsonString");
      var articles = NewsResponse.fromJson(json.decode(jsonString)).articles;
      return articles;
    } else {
      return null;
    }
  }

  static Future<List<sourcesModel.Sources>?> fetchSources() async {
    var url = '${Data.BASE_URL}/v2/sources?apiKey=${Data.API}';
    var response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var sourceList =
          sourcesModel.SourceResponse.fromJson(json.decode(jsonString)).sources;
      return sourceList;
    } else {
      return null;
    }
  }

  static Future<List<Articles>?> fetchResultsForQuery(String query) async {
    var url = '${Data.BASE_URL}/v2/everything?q=$query&apiKey=${Data.API}';
    var response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var articles = NewsResponse.fromJson(json.decode(jsonString)).articles;
      return articles;
    } else {
      return null;
    }
  }
}
