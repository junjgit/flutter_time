import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_task_provider.dart';

class TimeEntryListScreen extends StatelessWidget {
  const TimeEntryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProjectTaskProvider>(context);

    return ListView.builder(
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
    );
  }
}