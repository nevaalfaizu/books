import 'package:books/screens/books/book_table.dart';
import 'package:books/utils/layout.dart';
import 'package:flutter/material.dart';

class BookContent extends StatelessWidget {
  const BookContent({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      bodyContent: const BookTablePage(),
      seltitle: 'Books',
    );
  }

  // Placeholder, bisa dihilangkan
}
