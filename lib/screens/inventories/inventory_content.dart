import 'package:books/screens/inventories/inventory_table.dart';
import 'package:books/utils/layout.dart';
import 'package:flutter/material.dart';

class InventoryContent extends StatelessWidget {
  const InventoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      bodyContent: const InventoryTablePage(),
      seltitle: 'Inventories',
    );
  }
}
