import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart'; // Updated import path
import '../providers/project_task_provider.dart';

class TimeEntryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProjectTaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Entries'),
      ),
      body: ListView.builder(
        itemCount: provider.entries.length,
        itemBuilder: (context, index) {
          final entry = provider.entries[index];
          return ListTile(
            title: Text('${entry.projectId} - ${entry.totalTime} hours'),
            subtitle: Text('${entry.date.toString()} - Notes: ${entry.notes}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                provider.deleteTimeEntry(entry.id);
              },
            ),
          );
        },
      ),
    );
  }
}