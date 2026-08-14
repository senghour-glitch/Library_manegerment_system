import 'package:flutter/material.dart';
import 'package:library_onlile/model/homescreen_model.dart';

class HomeScreenProvider extends ChangeNotifier {
  final List<BookModel> books = [
    BookModel(
      title: 'Flutter',
      author: 'Google',
      image:
          'https://m.media-amazon.com/images/I/61ul0DfcYXL._AC_UF1000,1000_QL80_.jpg',
      category: 'Programming',
      rating: 4.8,
    ),

    BookModel(
      title: 'Java',
      author: 'James Gosling',
      image:
          'https://bpbonline.com/cdn/shop/products/1021_Front.jpg?v=1755670133',
      category: 'Programming',
      rating: 4.7,
    ),

    BookModel(
      title: 'Python',
      author: 'Eric Matthes',
      image:
          'https://m.media-amazon.com/images/I/810g00EIY8L._UF1000,1000_QL80_.jpg',
      category: 'Programming',
      rating: 4.9,
    ),

    BookModel(
      title: 'Data Structure',
      author: 'Robert Lafore',
      image:
          'https://m.media-amazon.com/images/I/71-XlTSt+pL._UF1000,1000_QL80_.jpg',
      category: 'Computer Science',
      rating: 4.6,
    ),
  ];

  String searchText = '';

  String selectedCategory = 'All';

  void searchBooks(String value) {
    searchText = value;
    notifyListeners();
  }

  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  List<BookModel> get filteredBooks {
    return books.where((book) {
      final bool matchesSearch =
          book.title.toLowerCase().contains(
                searchText.toLowerCase(),
              ) ||
          book.author.toLowerCase().contains(
                searchText.toLowerCase(),
              );

      final bool matchesCategory =
          selectedCategory == 'All' ||
          book.category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  List<String> get categories {
    return [
      'All',
      ...books.map(
        (book) => book.category,
      ).toSet(),
    ];
  }
}