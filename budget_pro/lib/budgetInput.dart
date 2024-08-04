import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:budget_pro/model/model.dart';

class Input extends StatefulWidget {
  final BudgetModel? budgetItem;
  final Function(BudgetModel) onSave;

  const Input({
    super.key,
    this.budgetItem,
    required this.onSave,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final _titleController = TextEditingController();
  final _spentAmountController = TextEditingController();
  DateTime? _pickedDate;
  String? _selectedCategory;
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();

    if (widget.budgetItem != null) {
      final item = widget.budgetItem!;
      _titleController.text = item.title;
      _spentAmountController.text = item.budgetAmount.toString();
      _pickedDate = item.date;
      _selectedCategory = item.category;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _spentAmountController.dispose();
    super.dispose();
  }

  void _fetchCategories() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      setState(() {
        _categories =
            snapshot.docs.map((doc) => doc['name'] as String).toList();
      });
    } catch (e) {
      print("Error fetching categories: $e");
    }
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

  void _submitData() {
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
          title: const Text("Invalid Input"),
          content: const Text("Please fill in all fields"),
          actions: <Widget>[
            TextButton(
              child: const Text("Okay"),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      );
      return;
    }

    final budgetItem = BudgetModel(
      id: widget.budgetItem?.id ?? '', // Use existing ID for editing
      title: title,
      budgetAmount: spentAmount,
      date: date,
      category: category,
    );

    widget.onSave(budgetItem);
    Navigator.pop(context);
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
                  keyboardType: TextInputType.number,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _pickedDate == null
                          ? "No Date Selected!"
                          : DateFormat.yMd().format(_pickedDate!),
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
                items: _categories.map((String category) {
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
                child: Text(widget.budgetItem == null ? "Add" : "Update"),
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
