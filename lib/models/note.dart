//import 'package:flutter/material.dart';

class Note {
  final String id;
  final String title;
  final String content;
  final String category;
  final DateTime createdAt;
  DateTime? deadline;
  bool isImportant;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.createdAt,
    this.deadline,
    this.isImportant = false,
  });
}
