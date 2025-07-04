// category_content.dart
import 'package:books/utils/layout.dart';
import 'package:flutter/material.dart';
import 'category_table.dart';

class CategoryContent extends StatelessWidget {
  const CategoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      bodyContent: const CategoryTablePage(),
      seltitle: 'Categories',
    );
  }
}
