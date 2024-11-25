import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';
import 'package:intl/intl.dart'; // For formatting dates

class NoteDetailScreen extends StatefulWidget {
  final Note? note;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  // Tambahkan ini
  Color selectedColor = Colors.blue;

  // Constructor with an optional note parameter
  NoteDetailScreen({this.note, super.key});

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _categoryController = TextEditingController();
  Color? _selectedColor;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      // If a note is passed, populate the fields with existing data
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      final _categoryController = TextEditingController();
      _selectedColor = widget.note!.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: _selectedColor ?? Colors.white,
      appBar: AppBar(
        title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Save or update the note
              if (_titleController.text.isNotEmpty) {
                if (widget.note == null) {
                  // Adding a new note
                  noteProvider.addNote(
                    Note(
                      id: DateTime.now().toString(),
                      title: _titleController.text,
                      content: _contentController.text,
                      color: _selectedColor ?? Colors.white,
                      date: DateFormat.yMMMd().format(DateTime.now()),
                    ),
                  );
                } else {
                  // Updating an existing note
                  noteProvider.updateNote(
                    this.id: widget.note!.id,
                    title: _titleController.text,
                    content: _contentController.text,
                    category: _categoryController.text,
                    color: _selectedColor ?? Colors.white,
                    date: widget.note!.date,
                  );
                }
                Navigator.of(context).pop();
              } else {
                // Show a warning if the title is empty
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Title cannot be empty')),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: () {
              // Show the color picker dialog
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Pick Note Color'),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      selectedColor: _selectedColor ?? Colors.white,
                      onColorSelected: (color) {
                        setState(() {
                          _selectedColor = color;
                        });
                        Navigator.of(ctx).pop();
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: null,
                expands: true,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Color Picker Widget to allow users to pick a background color
class ColorPicker extends StatelessWidget {
  final Color selectedColor;
  final Function(Color) onColorSelected;

  const ColorPicker({
    Key? key,
    required this.selectedColor,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of predefined color options
    final List<Color> colors = [
      Colors.white,
      Colors.yellow,
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.brown,
      Colors.pink,
      Colors.teal,
      Colors.cyan,
    ];

    return Wrap(
      children: colors.map((color) {
        return GestureDetector(
          onTap: () => onColorSelected(color),
          child: Container(
            margin: const EdgeInsets.all(4),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    selectedColor == color ? Colors.black : Colors.transparent,
                width: 2,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
