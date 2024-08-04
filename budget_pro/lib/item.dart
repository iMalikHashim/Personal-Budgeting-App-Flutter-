import 'package:flutter/material.dart';
import 'model/model.dart';

class Item extends StatelessWidget {
  final BudgetModel budget;
  final Function(BudgetModel) onEdit;
  final Function(String) onDelete;

  const Item({
    super.key,
    required this.budget,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal,
      elevation: 12.0,
      shadowColor: Color.fromARGB(1, 221, 6, 157),
      semanticContainer: true,
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14))),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            children: [
              Text(
                budget.title,
                style: TextStyle(
                  color: Colors.white, // Set font color to white
                  fontWeight: FontWeight.bold, // Make the text bold
                  fontSize: 20, // Set the font size to 25
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    'Rs. ${budget.budgetAmount}',
                    style: TextStyle(
                        color: Colors.white), // Set font color to white
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range_rounded,
                        color: Colors.white, // Set icon color to white
                      ),
                      Text(
                        budget.formattedDate,
                        style: TextStyle(
                            color: Colors.white), // Set font color to white
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white, // Set icon color to white
                    ),
                    onPressed: () => onEdit(budget),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white, // Set icon color to white
                    ),
                    onPressed: () => onDelete(budget.id),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
