import 'package:books/providers/book_provider.dart';
import 'package:books/providers/category_provider.dart';
import 'package:books/screens/books/book_table.dart';
import 'package:books/widgets/app_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: const BookContent(),
    ),
  );
}

class BookContent extends StatelessWidget {
  const BookContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Buku')),
      drawer: const AppSidebar(onSelectPage: _dummy), // Tambahkan sidebar
      body: const BookTablePage(),
    );
  }

  static void _dummy(int index) {} // Placeholder, bisa dihilangkan
}
