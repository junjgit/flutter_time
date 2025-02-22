import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart'; // Updated import path
import '../providers/project_task_provider.dart';

class AddTimeEntryScreen extends StatelessWidget {
  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Time Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final timeEntry = TimeEntry(
                  id: DateTime.now().toString(),
                  projectId: '1',
                  taskId: '1',
                  totalTime: 2.5,
                  date: DateTime.now(),
                  notes: _notesController.text,
                );
                Provider.of<ProjectTaskProvider>(context, listen: false).addTimeEntry(timeEntry);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}