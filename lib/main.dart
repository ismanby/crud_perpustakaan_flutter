import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://pgzqxaxgwlwbfkirsjdf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBnenF4YXhnd2x3YmZraXJzamRmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE3MjY1MzQsImV4cCI6MjA0NzMwMjUzNH0.25DARj3KES_pFNZAvd3JcX8MjgXlvH3044UFkHGlTiI',);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Perpustakaan',
      home: BookListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

