import 'package:flutter/material.dart';
import '../models/books_model.dart';
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

  Future<void> addBook({
    required String title,
    required String author,
    required int year,
    required int categoryId,
  }) async {
    try {
      final newBook = await BookService.createBook(
        title: title,
        author: author,
        year: year,
        categoryId: categoryId,
      );
      _books.add(newBook);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateBook({
    required int id,
    required String title,
    required String author,
    required int year,
    required int categoryId,
  }) async {
    try {
      final updatedBook = await BookService.updateBook(
        id: id,
        title: title,
        author: author,
        year: year,
        categoryId: categoryId,
      );
      final index = _books.indexWhere((book) => book.id == id);
      if (index != -1) {
        _books[index] = updatedBook;
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteBook(int id) async {
    try {
      await BookService.deleteBook(id);
      _books.removeWhere((book) => book.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<Book?> getBookById(int id) async {
    try {
      return await BookService.getBookById(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }
}
