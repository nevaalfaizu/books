import 'package:books/screens/inventories/inventory_table.dart';
import 'package:books/widgets/app_sidebar.dart';
import 'package:flutter/material.dart';

class InventoryContent extends StatelessWidget {
  const InventoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Inventory')),
      drawer: const AppSidebar(onSelectPage: _dummy),
      body: const InventoryTablePage(), // Ganti dengan isi kategori
    );
  }

  static void _dummy(int index) {}
}
