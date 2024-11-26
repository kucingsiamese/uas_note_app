import 'package:flutter/material.dart';

class Note {
  final String id;
  final String title;
  final String content;
  final String category;
  final DateTime createdAt;
  final Color color;
  final Color backgroundColor;
  final String date;
  DateTime? deadline;
  bool isImportant;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.backgroundColor,
    required this.category,
    required this.createdAt,
    required this.date,
    required this.color,
    this.deadline,
    this.isImportant = false,
  });
}
