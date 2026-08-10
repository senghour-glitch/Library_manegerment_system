import 'package:flutter/material.dart';
import 'package:library_onlile/model/home_screen_model.dart';

class HomeProvider extends ChangeNotifier {
  final List<BookModel> books = [
    BookModel(
      title: "Flutter",
      author: "Google",
      image:
          "https://m.media-amazon.com/images/I/61ul0DfcYXL._AC_UF1000,1000_QL80_.jpg",
      category: "Programming",
      rating: 4.8,
      isAvailable: true,
    ),
    BookModel(
      title: "Java",
      author: "James Gosling",
      image:
          "https://bpbonline.com/cdn/shop/products/1021_Front.jpg?v=1755670133",
      category: "Programming",
      rating: 4.7,
      isAvailable: true,
    ),
    BookModel(
      title: "Python",
      author: "Guido van Rossum",
      image:
          "https://m.media-amazon.com/images/I/810g00EIY8L._UF1000,1000_QL80_.jpg",
      category: "Programming",
      rating: 4.9,
      isAvailable: true,
    ),
    BookModel(
      title: "Data Structure",
      author: "Mark Allen Weiss",
      image:
          "https://m.media-amazon.com/images/I/71-XlTSt+pL._UF1000,1000_QL80_.jpg",
      category: "Computer",
      rating: 4.6,
      isAvailable: true,
    ),
  ];
  final List<BookModel> newArraivals = [
    BookModel(
      title: "Software Developer’s Career",
      author: "John Sonmez",
      image:
          "https://www.vojtechruzicka.com/book-review-the-complete-software-developers-career-guide/featured-Ap7ro3iiv--1200.avif",
      category: "Programming",
      rating: 4.2,
      isAvailable: true,
    ),
    BookModel(
      title: "JavaScript",
      author: "Alexei White",
      image:
          "https://m.media-amazon.com/images/I/51InSHdFQ6L._AC_UF1000,1000_QL80_.jpg",
      category: "Programming",
      rating: 4.5,
      isAvailable: true,
    ),
  ];

  String searchText = "";
  String selectedCategory = "All";

  void searchBook(String value) {
    searchText = value;
    notifyListeners();
  }

  void filterCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  List<BookModel> get filteredBooks {
    return books.where((book) {
      final matchesSearch = book.title.toLowerCase().contains(
        searchText.toLowerCase(),
      );

      final matchesCategory = selectedCategory == "All"
          ? true
          : book.category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }
}
