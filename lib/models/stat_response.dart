import 'stat_model.dart';

class StatResponse {
  final List<StatDaily> bookDaily;
  final List<StatDaily> categoryDaily;
  final List<StatDaily> inventoryDaily;
  final int totalBooks;
  final int totalCategories;
  final int totalInventories;

  StatResponse({
    required this.bookDaily,
    required this.categoryDaily,
    required this.inventoryDaily,
    required this.totalBooks,
    required this.totalCategories,
    required this.totalInventories,
  });

  factory StatResponse.fromJson(Map<String, dynamic> json) {
    return StatResponse(
      bookDaily:
          (json['book_daily'] as List)
              .map((e) => StatDaily.fromJson(e))
              .toList(),
      categoryDaily:
          (json['category_daily'] as List)
              .map((e) => StatDaily.fromJson(e))
              .toList(),
      inventoryDaily:
          (json['inventory_daily'] as List)
              .map((e) => StatDaily.fromJson(e))
              .toList(),
      totalBooks: json['total_books'] ?? 0,
      totalCategories: json['total_categories'] ?? 0,
      totalInventories: json['total_inventories'] ?? 0,
    );
  }
}
