import 'package:flutter/material.dart';
import 'model/model.dart';

class Item extends StatelessWidget {
  const Item({super.key, required this.budget});

  final BudgetModel budget;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(children: [
          Text(budget.title),
          const SizedBox(
            height: 2,
          ),
          Row(children: [
            Text('Rs. ${budget.budgetAmount}'),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.date_range_rounded),
                Text(budget.formattedDate),
              ],
            )
          ]),
        ]),
      ),
    );
  }
}
