import 'package:books/screens/books/book_content.dart';
import 'package:books/screens/categories/category_content.dart';
import 'package:books/screens/inventories/inventory_content.dart';
import 'package:flutter/material.dart';
// import 'package:books/screens/categories/category_table_page.dart';
// import 'package:books/screens/inventories/inventory_table_page.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key, required void Function(int index) onSelectPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu Navigasi',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Books'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const BookContent()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categories'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const CategoryContent()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Inventories'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const InventoryContent()),
              );
            },
          ),
        ],
      ),
    );
  }
}
