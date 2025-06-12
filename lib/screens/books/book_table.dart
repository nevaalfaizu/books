import 'package:books/providers/book_provider.dart';
import 'package:books/screens/books/book_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookTablePage extends StatefulWidget {
  const BookTablePage({super.key});

  @override
  State<BookTablePage> createState() => _BookTablePageState();
}

class _BookTablePageState extends State<BookTablePage> {
  final TextEditingController _searchController = TextEditingController();
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<BookProvider>(context, listen: false).fetchBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Buku')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child:
            provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.errorMessage != null
                ? Center(child: Text('Error: ${provider.errorMessage}'))
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top toolbar: Search and Add
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Cari judul atau penulis...',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: (value) {
                              // Implement search if needed
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const BookForm(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Tambah'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Full-width scrollable table with pagination
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: PaginatedDataTable(
                            header: const Text("Data Buku"),
                            rowsPerPage: _rowsPerPage,
                            onRowsPerPageChanged: (value) {
                              setState(() {
                                if (value != null) _rowsPerPage = value;
                              });
                            },
                            columns: const [
                              DataColumn(label: Text("ID")),
                              DataColumn(label: Text("Judul")),
                              DataColumn(label: Text("Penulis")),
                              DataColumn(label: Text("Tahun")),
                              DataColumn(label: Text("Kategori")),
                              DataColumn(label: Text("Aksi")),
                            ],
                            source: _BookDataTableSource(
                              provider.books,
                              context,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}

class _BookDataTableSource extends DataTableSource {
  final List books;
  final BuildContext context;

  _BookDataTableSource(this.books, this.context);

  @override
  DataRow getRow(int index) {
    if (index >= books.length) return const DataRow(cells: []);

    final book = books[index];

    return DataRow(
      cells: [
        DataCell(Text(book.id.toString())),
        DataCell(Text(book.title)),
        DataCell(Text(book.author)),
        DataCell(Text(book.year.toString())),
        DataCell(Text(book.category.name)),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => BookForm(book: book)),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: const Text("Konfirmasi Hapus"),
                          content: Text(
                            "Yakin ingin menghapus buku '${book.title}'?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("Batal"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("Hapus"),
                            ),
                          ],
                        ),
                  );

                  if (confirm == true) {
                    await Provider.of<BookProvider>(
                      context,
                      listen: false,
                    ).deleteBook(book.id);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => books.length;

  @override
  int get selectedRowCount => 0;
}
