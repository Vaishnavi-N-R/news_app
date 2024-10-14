class NewsResponse {
  String status;
  int totalResults;
  List<Articles> articles;

  NewsResponse(
      {required this.status,
      required this.totalResults,
      required this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: (json['articles'] as List)
          .map((article) => Articles.fromJson(article))
          .toList(),
    );
  }
}

class Articles {
  Source source;
  String? author; // Nullable
  String title;
  String? description;
  String url; // Should always be non-null
  String? urlToImage; // Nullable
  String publishedAt;
  String content;

  Articles({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      source: Source.fromJson(json['source']),
      author: json['author'], // Nullable
      title: json['title'] ?? 'No Title', // Default value if null
      description:
          json['description'] ?? 'No Description', // Default value if null
      url: json['url'] ?? '', // Default value or handle error
      urlToImage: json['urlToImage'] as String?, // Nullable
      publishedAt: json['publishedAt'] ?? '', // Default value if null
      content: json['content'] ?? '', // Default value if null
    );
  }
}

class Source {
  String? id; // Nullable
  String name;

  Source({this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] as String?, // Nullable
      name: json['name'] ?? 'No Name', // Default value if null
    );
  }
}
