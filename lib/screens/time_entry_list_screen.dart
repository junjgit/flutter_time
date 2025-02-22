import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/project_task_provider.dart';
import '../utils/dialogs.dart';

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
          title: Text('${entry.projectId} - ${entry.totalTime.toStringAsFixed(2)} hours'),
          subtitle: Text('${_formatDate(entry.date)} - Notes: ${entry.notes}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showConfirmationDialog(
                context: context,
                title: 'Delete Time Entry',
                content: 'Are you sure you want to delete this time entry?',
                onConfirm: () {
                  provider.deleteTimeEntry(entry.id);
                },
              );
            },
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}