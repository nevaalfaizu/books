import 'package:books/models/category_model.dart';

class Inventory {
  final int id;
  final String name;
  final int quantity;
  final int price;
  final int year;
  final int categoryId;
  final Category category;

  Inventory({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.year,
    required this.categoryId,
    required this.category,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
      year: json['year'],
      categoryId: json['category_id'],
      category: Category.fromJson(json['category'] ?? {}),
    );
  }
}

class InventoryListResponse {
  final List<Inventory> items;
  final int limit;
  final int page;
  final String search;
  final int total;
  final String year;

  InventoryListResponse({
    required this.items,
    required this.limit,
    required this.page,
    required this.search,
    required this.total,
    required this.year,
  });

  factory InventoryListResponse.fromJson(Map<String, dynamic> json) {
    return InventoryListResponse(
      items:
          (json['items'] as List)
              .map((item) => Inventory.fromJson(item))
              .toList(),
      limit: json['limit'],
      page: json['page'],
      search: json['search'],
      total: json['total'],
      year: json['year'],
    );
  }
}
