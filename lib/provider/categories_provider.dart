import 'package:flutter/material.dart';
import 'package:library_onlile/model/categories_model.dart';

enum CategoriesStatus {
  initial,
  loading,
  loaded,
  error,
}

class CategoriesProvider extends ChangeNotifier {
  CategoriesStatus _status = CategoriesStatus.initial;

  List<CategoryModel> _categories = [];

  String? _errorMessage;

  // Get status
  CategoriesStatus get status => _status;

  // Get categories
  List<CategoryModel> get categories => _categories;

  // Get error message
  String? get errorMessage => _errorMessage;

  // Check loading
  bool get isLoading =>
      _status == CategoriesStatus.loading;

  // Fetch categories
  Future<void> fetchCategories() async {
    _status = CategoriesStatus.loading;
    _errorMessage = null;

    notifyListeners();

    try {
      // Simulate loading
      await Future.delayed(
        const Duration(milliseconds: 500),
      );

      _categories = [
        CategoryModel(
          id: 'history',
          title: 'History',
          imageUrl:
              'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f',
          bookCount: 1240,
        ),

        CategoryModel(
          id: 'science',
          title: 'Science',
          imageUrl:
              'https://images.unsplash.com/photo-1532094349884-543bc11b234d',
          bookCount: 850,
        ),

        CategoryModel(
          id: 'novel',
          title: 'Novel',
          imageUrl:
              'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c',
          bookCount: 120,
        ),

        CategoryModel(
          id: 'arts',
          title: 'Arts',
          imageUrl:
              'https://images.unsplash.com/photo-1513364776144-60967b0f800f',
          bookCount: 430,
        ),

        CategoryModel(
          id: 'philosophy',
          title: 'Philosophy',
          imageUrl:
              'https://images.unsplash.com/photo-1608501078713-8e445a709b39',
          bookCount: 310,
        ),

        CategoryModel(
          id: 'technology',
          title: 'Technology',
          imageUrl:
              'https://images.unsplash.com/photo-1518770660439-4636190af475',
          bookCount: 2100,
        ),
      ];

      _status = CategoriesStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();

      _status = CategoriesStatus.error;
    }

    notifyListeners();
  }
}