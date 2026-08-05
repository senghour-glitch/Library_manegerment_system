import 'package:flutter/material.dart';
import 'package:library_onlile/model/homescreen.dart';

class HomeProvider extends ChangeNotifier {
  final List<BookModel> books = [
    BookModel(
      title: "Flutter",
      author: "Google",
      image: "",
      category: "Programming",
      rating: 4.8,
    ),
    BookModel(
      title: "Java",
      author: "James Gosling",
      image: "",
      category: "Programming",
      rating: 4.7,
    ),
    BookModel(
      title: "Python",
      author: "Guido",
      image: "",
      category: "Programming",
      rating: 4.9,
    ),
    BookModel(
      title: "Data Structure",
      author: "Mark Allen",
      image: "",
      category: "Computer",
      rating: 4.6,
    ),
  ];

  String search = "";

  List<BookModel> get filteredBooks {
    if (search.isEmpty) return books;

    return books.where((book) {
      return book.title.toLowerCase().contains(search.toLowerCase());
    }).toList();
  }

  void searchBook(String value) {
    search = value;
    notifyListeners();
  }
}