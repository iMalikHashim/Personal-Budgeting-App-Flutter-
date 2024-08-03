import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  const Input({super.key});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final _titleController = TextEditingController();
  final _spentAmountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _spentAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Expanded(
        child: Column(
          children: [
            TextField(
              maxLength: 50,
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: "Bought Something...",
              ),
            ),
            Row(
              children: [
                TextField(
                  controller: _spentAmountController,
                  decoration: const InputDecoration(
                    hintText: "250",
                    prefixText: "Rs.",
                  ),
                )
              ],
            ),
            ElevatedButton(
              onPressed: () => print(_titleController.text),
              child: Text("Print"),
            ),
          ],
        ),
      ),
    );
  }
}
