import 'package:books/models/category_model.dart';

class Book {
  final int id;
  final String title;
  final String author;
  final int year;
  final int categoryId;
  final Category category;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.year,
    required this.categoryId,
    required this.category,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      year: json['year'],
      categoryId: json['category_id'],
      category: Category.fromJson(json['category'] ?? {}),
    );
  }
}

class BookListResponse {
  final List<Book> items;
  final int limit;
  final int page;
  final String search;
  final int total;
  final String year;

  BookListResponse({
    required this.items,
    required this.limit,
    required this.page,
    required this.search,
    required this.total,
    required this.year,
  });

  factory BookListResponse.fromJson(Map<String, dynamic> json) {
    return BookListResponse(
      items:
          (json['items'] as List).map((item) => Book.fromJson(item)).toList(),
      limit: json['limit'],
      page: json['page'],
      search: json['search'],
      total: json['total'],
      year: json['year'],
    );
  }
}
