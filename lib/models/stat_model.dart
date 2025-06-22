class StatDaily {
  final String date;
  final int totalBooks;
  final int totalInventories;
  final int totalCategories;

  StatDaily({
    required this.date,
    required this.totalBooks,
    required this.totalInventories,
    required this.totalCategories,
  });

  factory StatDaily.fromJson(Map<String, dynamic> json) {
    return StatDaily(
      date: json['date'],
      totalBooks: json['total_books'] ?? 0,
      totalInventories: json['total_inventories'] ?? 0,
      totalCategories: json['total_categories'] ?? 0,
    );
  }
}
