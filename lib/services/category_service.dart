import 'package:books/api/dio_client.dart';
import '../models/category_model.dart';

class CategoryService {
  // GET: Ambil semua kategori
  static Future<List<Category>> getCategories() async {
    final response = await DioClient.dio.get('/categories');
    final data = response.data['items'] as List;
    return data.map((item) => Category.fromJson(item)).toList();
  }

  // GET: Ambil kategori berdasarkan ID
  static Future<Category> getCategoryById(int id) async {
    final response = await DioClient.dio.get('/categories/$id');
    return Category.fromJson(response.data['category']);
  }

  // POST: Tambah kategori baru
  static Future<Category> createCategory({
    required String name,
    required String description,
  }) async {
    final response = await DioClient.dio.post(
      '/categories',
      data: {'name': name, 'description': description},
    );

    return Category.fromJson(response.data['category']);
  }

  // PUT: Update kategori berdasarkan ID
  static Future<Category> updateCategory({
    required int id,
    required String name,
    required String description,
  }) async {
    final response = await DioClient.dio.put(
      '/categories/$id',
      data: {'name': name, 'description': description},
    );

    return Category.fromJson(response.data['category']);
  }

  // DELETE: Hapus kategori berdasarkan ID
  static Future<void> deleteCategory(int id) async {
    await DioClient.dio.delete('/categories/$id');
  }

  // static Future<List<StatDaily>> getStats() async {
  //   final response = await DioClient.dio.get('/categories/stats');
  //   final data = response.data as List;
  //   return data.map((json) => StatDaily.fromJson(json)).toList();
  // }
}
