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

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    DateTime? selectedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);

    setState(() {
      _pickedDate = selectedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _spentAmountController.dispose();
    super.dispose();
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
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => print(_titleController.text),
                child: const Text("Print"),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
