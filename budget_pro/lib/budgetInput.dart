import 'package:budget_pro/model/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Input extends StatefulWidget {
  const Input({super.key});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final _titleController = TextEditingController();
  final _spentAmountController = TextEditingController();
  DateTime? _pickedDate;
  String? _selectedCategory;

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

  Future<void> _submitData() async {
    final title = _titleController.text;
    final spentAmount = double.tryParse(_spentAmountController.text);
    final date = _pickedDate;
    final category = _selectedCategory;

    if (title.isEmpty ||
        spentAmount == null ||
        date == null ||
        category == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Invalid Input"),
          content: Text("Please fill in all fields"),
          actions: <Widget>[
            TextButton(
              child: Text("Okay"),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      );
      return;
    }

    try {
      // Add data to Firestore
      await FirebaseFirestore.instance.collection('budgetData').add({
        'title': title,
        'spentAmount': spentAmount,
        'date': date,
        'category': category,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data submitted successfully")),
      );

      _titleController.clear();
      _spentAmountController.clear();
      setState(() {
        _pickedDate = null;
        _selectedCategory = null;
      });
    } catch (error) {
      print("Error submitting data: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error submitting data")),
      );
    }
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
                onPressed: _submitData, // Submit data to Firestore
                child: const Text("Submit"),
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
