import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_task_provider.dart';
import 'time_entry_list_screen.dart';
import 'entries_by_project_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Time Tracker'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'All Entries'),
              Tab(icon: Icon(Icons.group_work), text: 'By Project'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TimeEntryListScreen(), // First tab: List of all entries
            EntriesByProjectScreen(), // Second tab: Entries grouped by project
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTimeEntryScreen(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}