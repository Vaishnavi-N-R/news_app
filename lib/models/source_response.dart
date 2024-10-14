class SourceResponse {
  String status;
  List<Sources> sources;

  // Constructor to initialize non-nullable fields
  SourceResponse({
    required this.status,
    required this.sources,
  });

  // Factory constructor to handle JSON deserialization
  factory SourceResponse.fromJson(Map<String, dynamic> json) {
    return SourceResponse(
      status: json['status'] as String,
      sources: (json['sources'] as List)
          .map((sourceJson) => Sources.fromJson(sourceJson))
          .toList(),
    );
  }

  // Method to convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'sources': sources.map((source) => source.toJson()).toList(),
    };
  }
}

class Sources {
  String id;
  String name;
  String description;
  String url;
  String category;
  String language;
  String country;

  // Constructor to initialize non-nullable fields
  Sources({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.category,
    required this.language,
    required this.country,
  });

  // Factory constructor to handle JSON deserialization
  factory Sources.fromJson(Map<String, dynamic> json) {
    return Sources(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      category: json['category'] as String,
      language: json['language'] as String,
      country: json['country'] as String,
    );
  }

  // Method to convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'url': url,
      'category': category,
      'language': language,
      'country': country,
    };
  }
}
