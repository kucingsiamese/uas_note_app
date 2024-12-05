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

  Color selectedColor = Colors.blue;
  DateTime? selectedDeadline;

  NoteDetailScreen({this.note, super.key});

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _categoryController = TextEditingController();
  Color? _selectedColor;
  DateTime? _selectedDeadline;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      _selectedColor = widget.note!.color;
      _selectedDeadline = widget.note!.deadline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: _selectedColor ?? Colors.black,
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
                      color: _selectedColor ?? Colors.black,
                      backgroundColor: Colors.black,
                      category: 'YourCategoryValue',
                      date: DateFormat.yMMMd().format(DateTime.now()),
                      createdAt: DateTime.now(),
                      deadline: _selectedDeadline,
                    ),
                  );
                } else {
                  // Updating an existing note
                  noteProvider.updateNote(
                    Note(
                      id: widget.note!.id,
                      title: _titleController.text,
                      content: _contentController.text,
                      category: _categoryController.text,
                      color: _selectedColor ?? Colors.black,
                      backgroundColor: Colors.black,
                      date: widget.note!.date,
                      createdAt: widget.note!.createdAt,
                      deadline: _selectedDeadline,
                      isImportant: widget.note!.isImportant,
                    ),
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
                      selectedColor: _selectedColor ?? Colors.black,
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
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              // Show a date picker for the deadline
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDeadline ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (selectedDate != null) {
                setState(() {
                  _selectedDeadline = selectedDate;
                });
              }
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
              cursorColor: Colors.black,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: null,
                expands: true,
                style: const TextStyle(fontSize: 16),
                cursorColor: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            if (_selectedDeadline != null)
              Text(
                'Deadline: ${DateFormat.yMMMd().format(_selectedDeadline!)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            const SizedBox(height: 10),
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
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    // List of color options
    final List<Color> colors = [
      const Color.fromARGB(195, 241, 236, 231),
      const Color.fromARGB(255, 223, 209, 89),
      const Color.fromARGB(255, 223, 135, 128),
      const Color.fromARGB(255, 99, 156, 202),
      const Color.fromARGB(255, 93, 223, 98),
      const Color.fromRGBO(221, 170, 93, 1),
      const Color.fromARGB(255, 217, 108, 236),
      Colors.brown,
      const Color.fromARGB(255, 235, 93, 140),
      const Color.fromARGB(255, 80, 182, 172),
      const Color.fromARGB(255, 66, 63, 226),
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
