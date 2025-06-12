import 'package:books/api/dio_client.dart';
import 'package:books/models/books_model.dart';

class BookService {
  static const String groupApi = '/books'; // Replace with your API base URL

  static Future<List<Book>> getBooks() async {
    try {
      final response = await DioClient.dio.get(groupApi);
      print(response.data);
      final data = BookListResponse.fromJson(response.data);

      return data.items;
    } catch (e) {
      throw Exception('Failed to fetch books: $e');
    }
  }

  static Future<Book> getBookById(int id) async {
    try {
      final response = await DioClient.dio.get('$groupApi/$id');
      return Book.fromJson(response.data['book']);
    } catch (e) {
      throw Exception('Failed to fetch book by ID: $e');
    }
  }
}
