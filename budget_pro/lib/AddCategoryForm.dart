import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCategoryForm extends StatefulWidget {
  final void Function(String, double) onAdd;

  const AddCategoryForm({super.key, required this.onAdd});

  @override
  State<AddCategoryForm> createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  final _categoryController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _categoryController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSubmitting) {
      return; // Prevent multiple submissions
    }

    setState(() {
      _isSubmitting = true;
    });

    final category = _categoryController.text.trim();
    final amount = double.tryParse(_amountController.text.trim());

    print("Submit called with category: $category and amount: $amount");

    if (category.isNotEmpty && amount != null && amount > 0) {
      try {
        // Check if the category already exists
        final querySnapshot = await FirebaseFirestore.instance
            .collection('categories')
            .where('category', isEqualTo: category)
            .get();

        if (querySnapshot.docs.isEmpty) {
          // If the category does not exist, add it to Firestore
          await FirebaseFirestore.instance.collection('categories').add({
            'category': category,
            'budget': amount,
          });

          widget.onAdd(category, amount);
          Navigator.of(context).pop(); // Close the bottom sheet

          // Show success message
          _showDialog("Success", "Category added successfully.");
        } else {
          // Show warning if the category already exists
          _showDialog("Category Exists", "This category already exists.");
        }
      } catch (e) {
        // Handle any errors here
        _showDialog("Error", "Failed to add category: $e");
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false; // Reset the flag
          });
        }
      }
    } else {
      // Show error message if input is invalid
      _showDialog("Invalid Input", "Please enter a valid category and amount.");

      setState(() {
        _isSubmitting = false; // Reset the flag if input is invalid
      });
    }
  }

  void _showDialog(String title, String content) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text("Okay"),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      );
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
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(labelText: 'Budget Amount'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isSubmitting ? null : _submit,
            child: _isSubmitting
                ? const CircularProgressIndicator()
                : const Text("Add Category"),
          ),
        ],
      ),
    );
  }
}
