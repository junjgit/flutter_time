import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_task_provider.dart';
import 'add_time_entry_screen.dart';
import 'time_entry_list_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tracker'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TimeEntryListScreen(),
              ),
            );
          },
          child: const Text('View Time Entries'),
        ),
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
    );
  }
}