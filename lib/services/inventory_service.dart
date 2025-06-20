import 'package:books/api/dio_client.dart';
import 'package:books/models/inventory_model.dart';

class InventoryService {
  static Future<List<Inventory>> getInventories() async {
    final Response = await DioClient.dio.get('/inventories');
    final data = Response.data['data'] as List;
    return data.map((item) => Inventory.fromJson(item)).toList();
  }

  static Future<Inventory> getInventoryById(int id) async {
    final response = await DioClient.dio.get('Inventories/$id');
    return Inventory.fromJson(response.data['Inventory']);
  }

  static Future<Inventory> createInventory({
    required String name,
    required int quantity,
    required int price,
    required int year,
    required int categoryId,
  }) async {
    final response = await DioClient.dio.post(
      '/inventories',
      data: {
        'name': name,
        'quantity': quantity,
        'price': price,
        'year': year,
        'category_id': categoryId,
      },
    );

    return Inventory.fromJson(response.data['inventory']);
  }

  static Future<Inventory> updateInventory({
    required int id,
    required String name,
    required int quantity,
    required int price,
    required int year,
    required int categoryId,
  }) async {
    final response = await DioClient.dio.put(
      '/inventories/$id',
      data: {
        'name': name,
        'quantity': quantity,
        'price': price,
        'year': year,
        'category_id': categoryId,
      },
    );

    return Inventory.fromJson(response.data['inventory']);
  }

  static Future<void> deleteInventery(int id) async {
    await DioClient.dio.delete('inventory/$id');
  }
}
