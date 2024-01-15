import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/charts/chart.dart';
import 'package:expense_tracker/widgets/expense_list/expense_list.dart';
import 'package:expense_tracker/widgets/expense_list/new_expense_modal.dart';
import 'package:flutter/material.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final List<Expense> _sampleList = [
    Expense(
        category: Category.leisure,
        title: "Cinema",
        amount: 20,
        date: DateTime.now()),
    Expense(
        category: Category.food,
        title: "Andra dining",
        amount: 200,
        date: DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("There is no Expense in the Tracker!"),
    );
    if (_sampleList.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _sampleList,
        onRemoveExpense: (Expense expense) {
          _removeExpense(expense);
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Expense Tracker!'),
        actions: [
          IconButton(
              onPressed: _openNewExpenseModal, icon: const Icon(Icons.add))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Chart(expenses: _sampleList),
            Expanded(child: mainContent)
          ],
        ),
      ),
    );
  }

  void _openNewExpenseModal() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (cxt) => NewExpenseModal(
              onAddExpenese: (Expense expense) {
                _addExpense(expense);
              },
            ));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _sampleList.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final index = _sampleList.indexOf(expense);
    setState(() {
      _sampleList.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expense deleted!'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _sampleList.insert(index, expense);
            });
          }),
    ));
  }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((ex) => ex.category == category).toList();

  ExpenseBucket({required this.category, required this.expenses});

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
