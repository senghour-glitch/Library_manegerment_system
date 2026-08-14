import 'package:flutter/material.dart';
import 'package:library_onlile/model/homescreen_model.dart';


class SearchProvider extends ChangeNotifier {
  final List<String> _recentSearches = [];
  String _currentSearchQuery = "";
  bool _isLoading = false;
  List<BookModel> _searchResults = [];

  bool get isLoading => _isLoading;
  List<String> get recentSearches => List.unmodifiable(_recentSearches);
  String get currentSearchQuery => _currentSearchQuery;
  List<BookModel> get searchResults => List.unmodifiable(_searchResults);

  void removeRecentSearch(String query) {
    _recentSearches.remove(query);
    notifyListeners();
  }

  void clearRecentSearches() {
    _recentSearches.clear();
    notifyListeners();
  }

  void performSearch(String query, List<BookModel> allBooks) {
    final cleanQuery = query.toLowerCase().trim();
    if (query.trim().isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _searchResults = allBooks.where((book) {
      final titleMatch = book.title.toLowerCase().contains(cleanQuery) ;
      final authorMatch = book.author.toLowerCase().contains(cleanQuery) ;
      final categoryMatch = book.category.toLowerCase().contains(cleanQuery) ;

      return titleMatch || authorMatch || categoryMatch;
    }).toList();

    if (cleanQuery.isEmpty) {
    _searchResults = List<BookModel>.from(allBooks);
  } else {
    _searchResults = allBooks.where((book) {
      final titleMatch = book.title.toLowerCase().contains(cleanQuery);
      final authorMatch = book.author.toLowerCase().contains(cleanQuery);
      final categoryMatch = book.category.toLowerCase().contains(cleanQuery);
      return titleMatch || authorMatch || categoryMatch;
    }).toList();
  }

  notifyListeners();

    notifyListeners();
  }

  void _executeBookSearch(String query, List<dynamic> booksList) {
    _isLoading = true;
    notifyListeners();

    final lowerQuery = query.toLowerCase();
    _searchResults = booksList
    .cast<BookModel>() 
    .where((book) {
      final titleMatch =
          book.title.toString().toLowerCase().contains(lowerQuery);
      final authorMatch =
          book.author.toString().toLowerCase().contains(lowerQuery);
      return titleMatch || authorMatch;
    })
    .toList();

    _isLoading = false;
    notifyListeners();
  }

  void onSearchSubmitted(
    String query,
    List<dynamic> booksList,
    TextEditingController controller,
  ) {
    final cleanQuery = query.trim();
    if (cleanQuery.isNotEmpty) {
      performSearch(cleanQuery, booksList.cast<BookModel>());
      controller.clear();
    }
  }

  void saveToRecentSearches(String query) {
    final cleanQuery = query.trim();
    if (cleanQuery.isEmpty) return;

    _recentSearches.remove(cleanQuery);
    _recentSearches.insert(0, cleanQuery);

    if (_recentSearches.length > 5) {
      _recentSearches.removeLast();
    }

    notifyListeners();
  }
}