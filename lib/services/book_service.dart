import 'package:books/api/dio_client.dart';
import '../models/books_model.dart';

class BookService {
  static Future<List<Book>> getBooks() async {
    final response = await DioClient.dio.get('/books');
    final data = response.data['items'] as List;
    return data.map((item) => Book.fromJson(item)).toList();
  }

  static Future<Book> getBookById(int id) async {
    final response = await DioClient.dio.get('/books/$id');
    return Book.fromJson(response.data['book']);
  }

  static Future<Book> createBook({
    required String title,
    required String author,
    required int year,
    required String description,
    required String? coverImageUrl,
    required int categoryId,
  }) async {
    final response = await DioClient.dio.post(
      '/books',
      data: {
        'title': title,
        'author': author,
        'year': year,
        'description': description,
        'cover_image_url': coverImageUrl,
        'category_id': categoryId,
      },
    );

    return Book.fromJson(response.data['book']);
  }

  static Future<Book> updateBook({
    required int id,
    required String title,
    required String author,
    required int year,
    required String description,
    required String? coverImageUrl,
    required int categoryId,
  }) async {
    final response = await DioClient.dio.put(
      '/books/$id',
      data: {
        'title': title,
        'author': author,
        'year': year,
        'description': description,
        'cover_image_url': coverImageUrl,
        'category_id': categoryId,
      },
    );

    return Book.fromJson(response.data['book']);
  }

  static Future<void> deleteBook(int id) async {
    await DioClient.dio.delete('/books/$id');
  }

  // static Future<List<StatDaily>> getStats() async {
  //   final response = await DioClient.dio.get('/books/stats');
  //   final data = response.data as List;
  //   return data.map((json) => StatDaily.fromJson(json)).toList();
  // }
}
