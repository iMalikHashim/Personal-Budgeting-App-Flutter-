import 'package:budget_pro/item.dart';
import 'package:flutter/material.dart';
import 'model/model.dart';

class ExpenseList extends StatelessWidget {
  final List<BudgetModel> expenseList;
  final Function(BudgetModel) onCardTap;
  final Function(String) onDelete;

  ExpenseList({
    super.key,
    required this.expenseList,
    required this.onCardTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenseList.length,
      itemBuilder: (context, index) => Item(
        budget: expenseList[index],
        onEdit: onCardTap,
        onDelete: onDelete,
      ),
    );
  }
}
