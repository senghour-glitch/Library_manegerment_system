import 'package:flutter/material.dart';
import 'package:library_onlile/model/bookdetails_model.dart';



enum BookDetailsStatus { initial, loading, loaded, error }

class BookDetailsProvider extends ChangeNotifier {
  BookDetailsStatus _status = BookDetailsStatus.initial;
  BookdetailModel? _book;
  String? _errorMessage;
  bool _isBorrowing = false;
  String? _borrowMessage;

  BookDetailsStatus get status => _status;
  BookdetailModel? get book => _book;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == BookDetailsStatus.loading;
  bool get isBorrowing => _isBorrowing;
  String? get borrowMessage => _borrowMessage;

  /// Fetches a single book by id. [fallbackTitle]/[fallbackImageUrl] are
  /// optional and only used to seed the mock data below (e.g. when you
  /// arrive here from a category card and don't have a real book id yet).
  Future<void> fetchBookDetails(
    String bookId, {
    String? fallbackTitle,
    String? fallbackImageUrl,
    String? categoryId,
  }) async {
    _status = BookDetailsStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 400));

      _book = BookdetailModel(
        id: bookId,
        title: fallbackTitle ?? 'The Architecture of Thought',
        author: 'Dr. Alistair Vance',
        rating: 4.9,
        pages: 432,
        language: 'ENG',
        copies: 12,
        coverUrl: fallbackImageUrl ??
            'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f',
        description:
            'An exhaustive exploration into the cognitive structures that '
            'define human innovation. This work serves as both a historical '
            'retrospective and a forward-looking guide for researchers and '
            'deep thinkers alike.',
        tags: [if (categoryId != null) categoryId, 'Featured'],
        categoryId: categoryId ?? 'general', image: '', category: '',
      );

      _status = BookDetailsStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = BookDetailsStatus.error;
    }
    notifyListeners();
  }

  Future<void> borrowBook() async {
    if (_book == null || _book!.copies <= 0 || _isBorrowing) return;

    _isBorrowing = true;
    _borrowMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _book = _book!.copyWith(copies: _book!.copies - 1);
      _borrowMessage = 'Borrowed successfully!';
    } catch (e) {
      _borrowMessage = 'Could not borrow this book. Please try again.';
    }

    _isBorrowing = false;
    notifyListeners();
  }
}