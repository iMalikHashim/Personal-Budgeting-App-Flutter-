import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final fDate = DateFormat.yMd();
const uid = Uuid();

class BudgetModel {
  BudgetModel({
    required this.title,
    required this.budgetAmount,
    this.spentAmount = 0.0,
    DateTime? date,
    required this.category,
  })  : id = uid.v4(),
        date = date ?? DateTime.now();

  final String id;
  final String title;
  final double budgetAmount;
  double spentAmount;
  final DateTime date;
  final String category;

  String get formattedDate {
    return fDate.format(date);
  }

  void updateSpentAmount(double amount) {
    if (amount <= budgetAmount) {
      spentAmount = amount;
    } else {
      throw Exception('Spent amount cannot exceed budget amount.');
    }
  }
}

class Category {
  static Set<String> categories = {'Food', 'Entertainment', 'Bills', 'Travel'};

  void addCategory(String newCategory) {
    if (categories.add(newCategory)) {
      print('Category added: $newCategory');
    } else {
      throw Exception('Category already exists.');
    }
  }

  Set<String> getCategories() {
    return categories;
  }
}
