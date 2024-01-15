import 'package:expense_tracker/widgets/expense.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 231, 191, 238),
    );
    final darkColorScheme = ColorScheme.fromSeed(
      seedColor: Color.fromARGB(255, 58, 61, 69),
    );
    return MaterialApp(
      darkTheme: ThemeData().copyWith(
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: colorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          foregroundColor: colorScheme.onPrimaryContainer,
          backgroundColor: colorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: colorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      home: const ExpensePage(),
    );
  }
}
