import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/project_task_provider.dart';

class ProjectTaskManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Projects and Tasks'),
      ),
      body: Consumer<ProjectTaskProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              // Projects Section
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Projects',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ...provider.projects.map((project) {
                return ListTile(
                  title: Text(project.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showEditProjectDialog(context, provider, project);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          provider.deleteProject(project.id);
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),

              const Divider(),

              // Tasks Section
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Tasks',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ...provider.tasks.map((task) {
                return ListTile(
                  title: Text(task.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showEditTaskDialog(context, provider, task);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          provider.deleteTask(task.id);
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddProjectOrTaskDialog(context);
        },
        child: const Icon(Icons.add),
        tooltip: 'Add Project/Task',
      ),
    );
  }

  void _showAddProjectOrTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Project or Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Add Project'),
                onTap: () {
                  Navigator.pop(context);
                  _showAddProjectDialog(context);
                },
              ),
              ListTile(
                title: const Text('Add Task'),
                onTap: () {
                  Navigator.pop(context);
                  _showAddTaskDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddProjectDialog(BuildContext context) {
    final _projectNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Project'),
          content: TextFormField(
            controller: _projectNameController,
            decoration: const InputDecoration(labelText: 'Project Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_projectNameController.text.isNotEmpty) {
                  final project = Project(
                    id: DateTime.now().toString(),
                    name: _projectNameController.text,
                  );
                  Provider.of<ProjectTaskProvider>(context, listen: false)
                      .addProject(project);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final _taskNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextFormField(
            controller: _taskNameController,
            decoration: const InputDecoration(labelText: 'Task Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_taskNameController.text.isNotEmpty) {
                  final task = Task(
                    id: DateTime.now().toString(),
                    name: _taskNameController.text,
                  );
                  Provider.of<ProjectTaskProvider>(context, listen: false)
                      .addTask(task);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showEditProjectDialog(
      BuildContext context, ProjectTaskProvider provider, Project project) {
    final _projectNameController = TextEditingController(text: project.name);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Project'),
          content: TextFormField(
            controller: _projectNameController,
            decoration: const InputDecoration(labelText: 'Project Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_projectNameController.text.isNotEmpty) {
                  final updatedProject = Project(
                    id: project.id,
                    name: _projectNameController.text,
                  );
                  provider.updateProject(updatedProject);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showEditTaskDialog(
      BuildContext context, ProjectTaskProvider provider, Task task) {
    final _taskNameController = TextEditingController(text: task.name);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextFormField(
            controller: _taskNameController,
            decoration: const InputDecoration(labelText: 'Task Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_taskNameController.text.isNotEmpty) {
                  final updatedTask = Task(
                    id: task.id,
                    name: _taskNameController.text,
                  );
                  provider.updateTask(updatedTask);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}