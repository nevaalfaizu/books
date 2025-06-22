// inventory_table.dart
import 'package:books/providers/inventory_provider.dart';
import 'package:books/screens/inventories/inventory_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryTablePage extends StatefulWidget {
  const InventoryTablePage({super.key});

  @override
  State<InventoryTablePage> createState() => _InventoryTablePageState();
}

class _InventoryTablePageState extends State<InventoryTablePage> {
  final TextEditingController _searchController = TextEditingController();
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<InventoryProvider>(context, listen: false).fetchInventories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InventoryProvider>(context);

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
                    // Search and Add
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Cari nama inventaris...',
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
                                        const InventoryForm(addInventory: true),
                              ),
                            );
                            if (result == true) {
                              Provider.of<InventoryProvider>(
                                context,
                                listen: false,
                              ).fetchInventories();
                            }
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Tambah'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Table
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: PaginatedDataTable(
                            header: const Text("Data Inventaris"),
                            rowsPerPage: _rowsPerPage,
                            onRowsPerPageChanged: (value) {
                              setState(() {
                                if (value != null) _rowsPerPage = value;
                              });
                            },
                            columns: const [
                              DataColumn(label: Text("NO")),
                              DataColumn(label: Text("Nama")),
                              DataColumn(label: Text("Quantity")),
                              DataColumn(label: Text("Harga")),
                              DataColumn(label: Text("Tahun")),
                              DataColumn(label: Text("Kategori")),
                              DataColumn(label: Text("Aksi")),
                            ],
                            source: _InventoryDataTableSource(
                              provider.inventories,
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

class _InventoryDataTableSource extends DataTableSource {
  final List inventories;
  final BuildContext context;

  _InventoryDataTableSource(this.inventories, this.context);

  @override
  DataRow getRow(int index) {
    if (index >= inventories.length) return const DataRow(cells: []);
    final inventory = inventories[index];

    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(inventory.name)),
        DataCell(Text(inventory.quantity.toString())),
        DataCell(Text(inventory.price.toString())),
        DataCell(Text(inventory.year.toString())),
        DataCell(Text(inventory.category.name)),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => InventoryForm(
                            inventory: inventory,
                            addInventory: false,
                          ),
                    ),
                  );
                  if (result == true) {
                    Provider.of<InventoryProvider>(
                      context,
                      listen: false,
                    ).fetchInventories();
                  }
                },
              ),
              // Jika ingin tambah tombol delete:
              // IconButton(
              //   icon: const Icon(Icons.delete),
              //   onPressed: () {},
              // ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => inventories.length;

  @override
  int get selectedRowCount => 0;
}
