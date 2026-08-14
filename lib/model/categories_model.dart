class CategoryModel {
  final String id;
  final String title;
  final String imageUrl;
  final int bookCount;

  const CategoryModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.bookCount,
  });

  factory CategoryModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return CategoryModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      bookCount: json['bookCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'bookCount': bookCount,
    };
  }

  String get formattedBookCount {
    return bookCount.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );
  }
}