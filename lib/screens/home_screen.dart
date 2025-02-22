import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/project_task_provider.dart';
import 'add_time_entry_screen.dart';
import '../utils/dialogs.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Entries'),
      ),
      body: Consumer<ProjectTaskProvider>(
        builder: (context, provider, child) {
          if (provider.entries.isEmpty) {
            return const Center(
              child: Text(
                'No time entries yet!\nTap the "+" button to add one.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            itemCount: provider.entries.length,
            itemBuilder: (context, index) {
              final entry = provider.entries[index];
              return ListTile(
                title: Text('${entry.projectId} - ${entry.totalTime.toStringAsFixed(2)} hours'),
                subtitle: Text('${_formatDate(entry.date)} - Notes: ${entry.notes}'),
                onTap: () {
                  // This could open a detailed view or edit screen
                },
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
        },
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
        tooltip: 'Add Time Entry',
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}