import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.food_bank,
  Category.travel: Icons.emoji_transportation,
  Category.leisure: Icons.face_2_rounded,
  Category.work: Icons.work,
};

class Expense {
  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Category category;

  Expense({
    required this.category,
    required this.title,
    required this.amount,
    required this.date,
  }) : id = uuid.v4();

  String get formattedDate {
    return DateFormat.yMd().format(date);
  }
}
