// category_content.dart
import 'package:books/widgets/app_sidebar.dart';
import 'package:flutter/material.dart';
import 'category_table.dart';

class CategoryContent extends StatelessWidget {
  const CategoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Kategori')),
      drawer: const AppSidebar(onSelectPage: _dummy), // Tambahkan sidebar
      body: const CategoryTablePage(),
    );
  }

  static void _dummy(int index) {} // Placeholder, bisa dihilangkan
}
