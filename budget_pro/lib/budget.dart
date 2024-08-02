import 'package:flutter/material.dart';
import 'model/model.dart';

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  final List<BudgetModel> _budgetList = [
    BudgetModel(
      title: "Anything",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Budget"),
      ),
      backgroundColor: Colors.blueAccent,
      body: const Column(
        children: [
          Text("Alpha"),
          Text("Beta"),
        ],
      ),
    );
  }
}
