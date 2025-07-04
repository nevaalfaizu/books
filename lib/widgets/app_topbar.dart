import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuPressed;

  const AppTopBar({super.key, required this.title, this.onMenuPressed});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading:
          isDesktop
              ? null
              : IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: onMenuPressed,
              ),
      title: Row(
        children: [
          if (!isDesktop)
            Text(title, style: const TextStyle(color: Colors.black)),
          if (isDesktop) Expanded(child: _buildSearchBar()),
        ],
      ),
      actions: [_buildProfileIcon()],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
              onSubmitted: (query) {
                debugPrint('Search: $query');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileIcon() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade300,
        child: IconButton(
          icon: const Icon(Icons.person, color: Colors.black),
          onPressed: () {
            debugPrint('Profile clicked');
          },
        ),
      ),
    );
  }
}
