import 'package:budget_pro/item.dart';
import 'package:flutter/material.dart';
import 'model/model.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList({super.key, required this.expenseList});

  List<BudgetModel> expenseList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenseList.length,
        itemBuilder: (context, index) => Item(budget: expenseList[index]));
  }
}
