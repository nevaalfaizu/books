import 'package:books/api/dio_client.dart';
import 'package:books/models/category_model.dart';

class CategoryService {
  static Future<List<Category>> getCategories() async {
    final response = await DioClient.dio.get('/categories');
    final List data = response.data['items'];
    return data.map((json) => Category.fromJson(json)).toList();
  }
}
