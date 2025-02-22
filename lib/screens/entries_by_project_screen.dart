import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/project_task_provider.dart';

class EntriesByProjectScreen extends StatelessWidget {
  const EntriesByProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProjectTaskProvider>(context);

    // Group entries by project
    final Map<String, List<TimeEntry>> entriesByProject = {};
    for (final entry in provider.entries) {
      if (!entriesByProject.containsKey(entry.projectId)) {
        entriesByProject[entry.projectId] = [];
      }
      entriesByProject[entry.projectId]!.add(entry);
    }

    return ListView.builder(
      itemCount: entriesByProject.length,
      itemBuilder: (context, index) {
        final projectId = entriesByProject.keys.elementAt(index);
        final entries = entriesByProject[projectId]!;

        return ExpansionTile(
          title: Text('Project: $projectId'),
          children: entries.map<Widget>((entry) {
            return ListTile(
              title: Text('${entry.taskId} - ${entry.totalTime} hours'),
              subtitle: Text('${entry.date.toString()} - Notes: ${entry.notes}'),
            );
          }).toList(),
        );
      },
    );
  }
}