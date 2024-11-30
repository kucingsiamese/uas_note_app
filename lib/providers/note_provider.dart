import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  String _searchQuery = '';
  String _categoryFilter = 'All';
  DateTime? _deadlineFilter;

  List<Note> get notes {
    return _notes.where((note) {
      // Check category and search query filters
      final matchesCategory =
          _categoryFilter == 'All' || note.category == _categoryFilter;
      final matchesSearch =
          note.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              note.content.toLowerCase().contains(_searchQuery.toLowerCase());

      // Check deadline filter
      final matchesDeadline = _deadlineFilter == null ||
          (note.deadline != null && note.deadline!.isBefore(_deadlineFilter!));

      return matchesCategory && matchesSearch && matchesDeadline;
    }).toList();
  }

  // to add a new note
  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  // to update an existing note
  void updateNote(Note note) {
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note;
      notifyListeners();
    }
  }

  // to delete a note by ID
  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  // to search notes by title or content
  void searchNotes(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // to filter notes by category
  void filterByCategory(String category) {
    _categoryFilter = category;
    notifyListeners();
  }

  // to filter notes by deadline
  void filterByDeadline(DateTime? deadline) {
    _deadlineFilter = deadline;
    notifyListeners();
  }

  // to clear the search filter
  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  // to clear the deadline filter
  void clearDeadlineFilter() {
    _deadlineFilter = null;
    notifyListeners();
  }
}
