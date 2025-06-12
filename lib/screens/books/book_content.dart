import 'package:books/providers/book_provider.dart';
import 'package:books/screens/books/book_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => BookProvider())],
      child: const BookContent(),
    ),
  );
}

class BookContent extends StatelessWidget {
  const BookContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BookTablePage(),
    );
  }
}
