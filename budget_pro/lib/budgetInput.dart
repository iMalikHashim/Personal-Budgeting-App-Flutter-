import 'package:budget_pro/model/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Input extends StatefulWidget {
  const Input({super.key});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final _titleController = TextEditingController();
  final _spentAmountController = TextEditingController();
  DateTime? _pickedDate;
  String? _selectedCategory; // Variable to track the selected category

  @override
  void dispose() {
    _titleController.dispose();
    _spentAmountController.dispose();
    super.dispose();
  }

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _pickedDate = selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: "Title: Bought Something...",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: _spentAmountController,
                  decoration: const InputDecoration(
                    hintText: "250",
                    prefixText: "Rs. ",
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _pickedDate == null
                          ? "No Date Selected!"
                          : fDate.format(_pickedDate!),
                    ),
                    IconButton(
                      onPressed: _datePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 6),
          Row(
            children: [
              DropdownButton<String>(
                hint: const Text("Select Category"),
                value: _selectedCategory,
                items: Category.categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  print("Title: ${_titleController.text}");
                  print("Spent Amount: ${_spentAmountController.text}");
                  print(
                      "Date: ${_pickedDate != null ? fDate.format(_pickedDate!) : 'No Date Selected'}");
                  print("Category: $_selectedCategory");
                },
                child: const Text("Print"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
