import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(expense.title),
          Row(
            children: [
              Text(expense.amount.toStringAsFixed(2)),
              const Spacer(),
              Row(
                children: [
                  Icon(categoryIcons[expense.category]),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(expense.formattedDate)
                ],
              )
            ],
          )
        ],
      ),
    ));
  }
}
