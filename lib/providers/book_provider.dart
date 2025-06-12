import 'package:books/models/books_model.dart';
import 'package:flutter/material.dart';
import '../services/book_service.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Book> get books => _books;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchBooks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _books = await BookService.getBooks();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
