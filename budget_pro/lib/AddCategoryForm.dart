import 'package:flutter/material.dart';

class AddCategoryForm extends StatefulWidget {
  final void Function(String) onAdd;

  const AddCategoryForm({super.key, required this.onAdd});

  @override
  State<AddCategoryForm> createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  final _categoryController = TextEditingController();

  void _submit() {
    final category = _categoryController.text.trim();
    if (category.isNotEmpty) {
      widget.onAdd(category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _categoryController,
            decoration: const InputDecoration(labelText: 'Category Name'),
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Add Category'),
          ),
        ],
      ),
    );
  }
}
