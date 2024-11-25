import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../screens/note_detail_screen.dart';

class NoteList extends StatelessWidget {
  const NoteList({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NoteProvider>(context).notes;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: notes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) {
        final note = notes[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => NoteDetailScreen(note: note),
              ),
            );
          },
          child: Card(
            child: Column(
              children: [
                Text(note.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(note.content, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        );
      },
    );
  }
}
