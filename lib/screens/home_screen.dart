import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../screens/note_detail_screen.dart';
import '../widgets/note_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final notes = noteProvider.notes;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 196, 129, 250),
      appBar: AppBar(
        title: const Text(
          'My Notes',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to NoteDetailScreen for creating a new note
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => NoteDetailScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: notes.isEmpty
          ? const Center(
              child: Text(
                'No Notes Yet. Click + to Add',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: notes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (ctx, index) {
                  final note = notes[index];
                  return GestureDetector(
                    onTap: () {
                      // Open the NoteDetailScreen for editing
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => NoteDetailScreen(note: note),
                        ),
                      );
                    },
                    child: Card(
                      color: note.backgroundColor ??
                          const Color.fromARGB(255, 23, 176, 247),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                note.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: Text(
                                note.content,
                                style: const TextStyle(fontSize: 14),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    // Delete the note
                                    noteProvider.deleteNote(note.id);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    // Edit the note
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) =>
                                            NoteDetailScreen(note: note),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
