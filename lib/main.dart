import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../screens/auth_screen.dart';
import '../screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData.light(), // Light Theme
      darkTheme: ThemeData.dark(), // Dark Theme
      themeMode: ThemeMode.system, // Automatically switch based on system
      initialRoute: '/',
      routes: {
        '/': (ctx) => const AuthScreen(), // Auth Screen sebagai halaman awal
        '/home': (ctx) => const HomeScreen(),
      },
    );
  }
}
