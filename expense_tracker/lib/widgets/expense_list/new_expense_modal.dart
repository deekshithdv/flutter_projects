import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpenseModal extends StatefulWidget {
  const NewExpenseModal({super.key, required this.onAddExpenese});

  final void Function(Expense expense) onAddExpenese;

  @override
  State<NewExpenseModal> createState() => _NewExpenseModalState();
}

class _NewExpenseModalState extends State<NewExpenseModal> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String dateField = 'Date not selected';
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          TextField(
            maxLength: 50,
            controller: _amountController,
            decoration:
                const InputDecoration(label: Text("Amount"), prefixText: '\$'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(dateField),
              const Spacer(),
              IconButton(
                onPressed: _onCalenderPressed,
                icon: const Icon(
                  Icons.calendar_month,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          DropdownButton(
              isExpanded: true,
              value: _selectedCategory,
              items: Category.values
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                setState(() {
                  _selectedCategory = value;
                });
              }),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () => _submitExpenseData(),
                  child: const Text("Save expense")),
              const SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
          )
        ],
      ),
    );
  }

  void _onCalenderPressed() {
    final now = DateTime.now();
    showDatePicker(
            context: context,
            initialDate: now,
            firstDate: DateTime(DateTime.april),
            lastDate: now)
        .then((value) => _updateDate(value.toString()));
  }

  void _updateDate(String date) {
    setState(() {
      dateField = date;
    });
  }

  void _submitExpenseData() {
    if (_titleController.text.isNotEmpty &&
        _amountController.text.isNotEmpty &&
        dateField.isNotEmpty) {
      widget.onAddExpenese(Expense(
          category: _selectedCategory,
          title: _titleController.text,
          amount: double.tryParse(_amountController.text)!,
          date: DateTime.parse(dateField)));
      Navigator.pop(context);
    }
  }
}
