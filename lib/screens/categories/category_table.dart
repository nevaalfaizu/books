// category_table.dart
import 'package:books/providers/category_provider.dart';
import 'package:books/screens/categories/category_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryTablePage extends StatefulWidget {
  const CategoryTablePage({super.key});

  @override
  State<CategoryTablePage> createState() => _CategoryTablePageState();
}

class _CategoryTablePageState extends State<CategoryTablePage> {
  final TextEditingController _searchController = TextEditingController();
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);

    return Scaffold(
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
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Cari nama kategori...',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) =>
                                        const CategoryForm(addCategory: true),
                              ),
                            );
                            if (result == true) {
                              Provider.of<CategoryProvider>(
                                context,
                                listen: false,
                              ).fetchCategories();
                            }
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Tambah'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: PaginatedDataTable(
                            header: const Text("Data Kategori"),
                            rowsPerPage: _rowsPerPage,
                            onRowsPerPageChanged: (value) {
                              setState(() {
                                if (value != null) _rowsPerPage = value;
                              });
                            },
                            columns: const [
                              DataColumn(label: Text("NO")),
                              DataColumn(label: Text("Nama")),
                              DataColumn(label: Text("Deskripsi")),
                              DataColumn(label: Text("Aksi")),
                            ],
                            source: _CategoryDataTableSource(
                              provider.categories,
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

class _CategoryDataTableSource extends DataTableSource {
  final List categories;
  final BuildContext context;

  _CategoryDataTableSource(this.categories, this.context);

  @override
  DataRow getRow(int index) {
    if (index >= categories.length) return const DataRow(cells: []);
    final category = categories[index];

    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(category.name)),
        DataCell(Text(category.description)),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {
                  Navigator.pushNamed(context, '/category/${category.id}');
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => CategoryForm(
                            category: category,
                            addCategory: false,
                          ),
                    ),
                  );
                  if (result == true) {
                    Provider.of<CategoryProvider>(
                      context,
                      listen: false,
                    ).fetchCategories();
                  }
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
                            "Yakin ingin menghapus buku '${category.name}'?",
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
                    await Provider.of<CategoryProvider>(
                      context,
                      listen: false,
                    ).deleteCategory(category.id);
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
  int get rowCount => categories.length;

  @override
  int get selectedRowCount => 0;
}

// inventory_table.dart (struktur hampir sama dengan category_table.dart, ganti model, provider dan form sesuai kebutuhan)
