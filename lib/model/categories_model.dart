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

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      bookCount: json['bookCount'] as int,
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

  /// Nicely formatted count, e.g. "1,240"
  String get formattedBookCount {
    final s = bookCount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromEnd = s.length - i;
      buffer.write(s[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write(',');
    }
    return buffer.toString();
  }
}