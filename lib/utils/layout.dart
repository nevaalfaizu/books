import 'package:flutter/material.dart';
import 'package:books/widgets/app_sidebar.dart';
import 'package:books/widgets/app_topbar.dart';

class DashboardLayout extends StatelessWidget {
  final String seltitle;
  final Widget bodyContent;

  const DashboardLayout({
    super.key,
    required this.bodyContent,
    required this.seltitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      drawer: isDesktop ? null : AppSidebar(selectedPageTitle: seltitle),
      body: Row(
        children: [
          if (isDesktop)
            SizedBox(
              width: 250,
              child: AppSidebar(selectedPageTitle: seltitle),
            ),
          Expanded(
            child: Column(
              children: [
                AppTopBar(
                  title: 'Index : $seltitle',
                  onMenuPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                Expanded(child: bodyContent),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
