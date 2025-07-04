import 'package:books/screens/books/book_content.dart';
import 'package:books/screens/categories/category_content.dart';
import 'package:books/screens/home_screen.dart';
import 'package:books/screens/inventories/inventory_content.dart';
import 'package:flutter/material.dart';

class AppSidebar extends StatelessWidget {
  final String selectedPageTitle;
  const AppSidebar({super.key, required this.selectedPageTitle});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(0)),
      ),
      child: Container(
        color: const Color.fromARGB(255, 218, 216, 216),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 221, 221),
              ),
              child: Center(
                child: Text(
                  selectedPageTitle,
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
              ),
            ),
            _buildMenuItem(Icons.dashboard, 'Dashboard', context, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HomeScreen()),
              );
            }),
            _buildMenuItem(Icons.book, 'Books', context, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BookContent()),
              );
            }),
            _buildMenuItem(Icons.inventory, 'Inventories', context, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => InventoryContent()),
              );
            }),
            _buildMenuItem(Icons.category, 'Categories', context, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CategoryContent()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    BuildContext context,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(
          color: selectedPageTitle == title ? Colors.grey : Colors.black,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // Tutup drawer
        onTap();
      },
    );
  }
}
