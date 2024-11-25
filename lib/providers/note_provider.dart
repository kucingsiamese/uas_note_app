import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  String _searchQuery = '';
  String _categoryFilter = 'All';

  List<Note> get notes {
    if (_categoryFilter == 'All' && _searchQuery.isEmpty) {
      return _notes;
    } else {
      return _notes.where((note) {
        final matchesCategory =
            _categoryFilter == 'All' || note.category == _categoryFilter;
        final matchesSearch = note.title.contains(_searchQuery) ||
            note.content.contains(_searchQuery);
        return matchesCategory && matchesSearch;
      }).toList();
    }
  }

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(Note note) {
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note;
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  void searchNotes(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void filterByCategory(String category) {
    _categoryFilter = category;
    notifyListeners();
  }
}
