import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ksp_datathon/features/user_auth/presentation/widgets/web_view_container.dart';
import 'search_screen.dart'; // Adjust the import path as needed
import 'task_screen_web.dart'; // Adjust the import path as needed
class HomePageWeb extends StatefulWidget {
  const HomePageWeb({super.key});

  @override
  _HomePageWebState createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Color darkGreen;
  late Color lightGreen;

  @override
  void initState() {
    super.initState();
    darkGreen = const Color(0xFF1f9c16); // Dark green color
    lightGreen = const Color(0xFFcaf2c7); // Light green color
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (mounted) {
      setState(() {}); // Rebuilds the AppBar whenever the tab selection changes
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen, // Dark green background for the AppBar
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent, // No indicator beneath the tabs
          tabs: List.generate(3, (index) {
            return Tab(
              child: Container(
                width: double.infinity,
                color: _tabController.index == index ? lightGreen : Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  ['Home', 'Search', 'Tasks'][index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          WebViewContainer(), // Home screen content
          SearchScreenWeb(),  // Search screen
          TaskScreenWeb(),    // Task update/assignment screen
        ],
      ),
    );
  }
}