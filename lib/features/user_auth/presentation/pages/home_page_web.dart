import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ksp_datathon/features/user_auth/presentation/widgets/web_view_container.dart';
import 'search_screen.dart'; // Adjust the import path as needed
import 'task_screen_web.dart'; // Adjust the import path as needed

class HomePageWeb extends StatefulWidget {
  const HomePageWeb({Key? key}) : super(key: key);

  @override
  _HomePageWebState createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web App'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Home'),
            Tab(text: 'Search'),
            Tab(text: 'Tasks'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          WebViewContainer(), // Home screen content
          SearchScreenWeb(), // Search screen
          TaskScreenWeb(), // Task update/assignment screen
        ],
      ),
    );
  }
}