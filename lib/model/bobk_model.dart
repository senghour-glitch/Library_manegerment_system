class BookModel{


  String title;
  String author;
  String image;
  String category;
  bool favorite;


  BookModel({

    required this.title,
    required this.author,
    required this.image,
    required this.category,
    this.favorite=false,

  });


}