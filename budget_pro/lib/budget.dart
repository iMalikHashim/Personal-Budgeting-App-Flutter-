import 'package:budget_pro/budget_list.dart';
import 'package:flutter/material.dart';
import 'model/model.dart';

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  // List to hold categories for indexed access
  List<String> categoriesList = [];

  // List to hold budget items
  List<BudgetModel> _budgetList = [];

  @override
  void initState() {
    super.initState();

    // Initialize the categoriesList in initState
    categoriesList = Category.categories.toList();

    // Initialize the _budgetList after categoriesList is available
    _budgetList = [
      BudgetModel(
        title: "Anything",
        budgetAmount: 1000,
        date: DateTime.now(),
        category: categoriesList[0],
      ),
      BudgetModel(
        title: "Nothing",
        budgetAmount: 2000,
        date: DateTime.now(),
        category: categoriesList[1],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Budget"),
      ),
      body: Column(
        children: [
          const Text("Alpha"),
          Expanded(
            child: ExpenseList(expenseList: _budgetList),
          ),
        ],
      ),
    );
  }
}
