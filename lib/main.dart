import 'package:flutter/material.dart';
import 'matches_page.dart';

// Alfa Aditya Wicaksana
// 123200094/H

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COPA 22 Medeiro API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MatchesPage(),
    );
  }
}
