import 'package:flutter/material.dart';
import 'book_form.dart';
import 'book_table.dart';

class BookContent extends StatelessWidget {
  const BookContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manajemen Buku")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            // BookForm(),
            SizedBox(height: 16),
            Expanded(child: BookTable()),
          ],
        ),
      ),
    );
  }
}
