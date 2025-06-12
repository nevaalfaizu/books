import 'package:books/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookTable extends StatelessWidget {
  const BookTable({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return Center(child: Text("Error: ${provider.errorMessage}"));
    }

    final books = provider.books;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("ID")),
          DataColumn(label: Text("Judul")),
          DataColumn(label: Text("Penulis")),
          DataColumn(label: Text("Tahun")),
          DataColumn(label: Text("Kategori")),
        ],
        rows:
            books
                .map(
                  (book) => DataRow(
                    cells: [
                      DataCell(Text(book.id.toString())),
                      DataCell(Text(book.title)),
                      DataCell(Text(book.author)),
                      DataCell(Text(book.year.toString())),
                      DataCell(Text(book.category.name)),
                    ],
                  ),
                )
                .toList(),
      ),
    );
  }
}
