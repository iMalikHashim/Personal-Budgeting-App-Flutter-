import 'package:flutter/material.dart';
import 'model/model.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList({super.key, required this.expenseList});

  List<BudgetModel> expenseList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Text(expenseList[index].title),
    );
  }
}
