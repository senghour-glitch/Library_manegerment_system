class BookModel {
  final String title;
  final String author;
  final String image;
  final String category;
  final double rating;
  final bool isAvailable;

  BookModel({
    required this.title,
    required this.author,
    required this.image,
    required this.category,
    required this.rating,
    required this.isAvailable,
  });
}