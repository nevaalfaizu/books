import 'package:flutter/material.dart';
import 'package:books/utils/layout.dart'; // file layout utama (sidebar + topbar + body)
import 'package:books/providers/stat_provider.dart';
import 'package:provider/provider.dart';
import 'package:books/widgets/stat_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<StatProvider>(context, listen: false).loadStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      seltitle: 'Dashboard',
      bodyContent: Consumer<StatProvider>(
        builder: (context, provider, _) {
          final stats = provider.stats;

          if (stats == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [
                SizedBox(height: 16),
                Row(
                  children: [
                    _buildTotalCard(
                      title: 'Books',
                      total: stats.totalBooks,
                      color: Colors.blue,
                      routeName: '/books',
                    ),
                    const SizedBox(width: 8),
                    _buildTotalCard(
                      title: 'Inventories',
                      total: stats.totalInventories,
                      color: Colors.green,
                      routeName: '/inventories',
                    ),
                    const SizedBox(width: 8),
                    _buildTotalCard(
                      title: 'Categories',
                      total: stats.totalCategories,
                      color: Colors.red,
                      routeName: '/categories',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                StatChart(
                  data: stats.bookDaily,
                  title: 'Books',
                  color: Colors.blue,
                  getValue: (s) => s.totalBooks,
                ),
                StatChart(
                  data: stats.inventoryDaily,
                  title: 'Inventories',
                  color: Colors.green,
                  getValue: (s) => s.totalInventories,
                ),
                StatChart(
                  data: stats.categoryDaily,
                  title: 'Categories',
                  color: Colors.red,
                  getValue: (s) => s.totalCategories,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTotalCard({
    required String title,
    required int total,
    required Color color,
    required String routeName,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  total.toString(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
