import 'package:flutter/material.dart';
import '../models/models.dart'; // Updated import path

class ProjectTaskProvider with ChangeNotifier {
  List<TimeEntry> _entries = [];

  List<TimeEntry> get entries => _entries;

  void addTimeEntry(TimeEntry entry) {
    _entries.add(entry);
    notifyListeners();
  }

  void deleteTimeEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    notifyListeners();
  }
}