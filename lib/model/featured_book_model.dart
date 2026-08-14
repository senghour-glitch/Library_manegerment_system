class FeaturedBookModel {
  final String title;
  final String author;
  final String bookImage;
  final double rating;
  FeaturedBookModel({
    required this.title,
    required this.author,
    required this.rating,
    required this.bookImage,
  });
  static List<FeaturedBookModel> featuredBook = [
    FeaturedBookModel(
      title: "The Future of Space Exploration",
      author: "Dr. Elena Sterling",
      bookImage: "https://m.media-amazon.com/images/I/81kkCXShbhL._UF1000,1000_QL80_.jpg",
      rating: 4.8,
    ),
    FeaturedBookModel(
    title: "Deep Leaning",
    author: "Erich Gamma",
    bookImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5delHCmIB6hVV5l1zCB7hNDWdEuDB97h_x2NspZGzpa8EyaTuiI0q5qTU&s=10",
    rating: 4.7,
  ),
  ];
}