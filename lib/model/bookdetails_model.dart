class BookdetailModel {
  final String id;
  final String title;
  final String author;
  final double rating;
  final int pages;
  final String language;
  final int copies;
  final String coverUrl;
  final String description;
  final List<String> tags;
  final String categoryId;

  const BookdetailModel({
    required this.id,
    required this.title,
    required this.author,
    required this.rating,
    required this.pages,
    required this.language,
    required this.copies,
    required this.coverUrl,
    required this.description,
    required this.tags,
    required this.categoryId, required String image, required String category,
  });

  factory BookdetailModel.fromJson(Map<String, dynamic> json) {
    return BookdetailModel(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      rating: (json['rating'] as num).toDouble(),
      pages: json['pages'] as int,
      language: json['language'] as String,
      copies: json['copies'] as int,
      coverUrl: json['coverUrl'] as String,
      description: json['description'] as String,
      tags: List<String>.from(json['tags'] as List),
      categoryId: json['categoryId'] as String, image: '', category: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'rating': rating,
      'pages': pages,
      'language': language,
      'copies': copies,
      'coverUrl': coverUrl,
      'description': description,
      'tags': tags,
      'categoryId': categoryId,
    };
  }

  BookdetailModel copyWith({int? copies}) {
    return BookdetailModel(
      id: id,
      title: title,
      author: author,
      rating: rating,
      pages: pages,
      language: language,
      copies: copies ?? this.copies,
      coverUrl: coverUrl,
      description: description,
      tags: tags,
      categoryId: categoryId, image: '', category: '',
    );
  }
}