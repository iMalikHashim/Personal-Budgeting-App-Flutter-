import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budget_pro/budgetInput.dart';
import 'package:budget_pro/budget_list.dart';
import 'package:budget_pro/AddCategoryForm.dart';
import 'package:budget_pro/model/model.dart';

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  List<BudgetModel> _budgetList = [];
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchBudgetData();
    _fetchCategories();
  }

  void _fetchBudgetData() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('budgetData').get();

      List<BudgetModel> budgetList = snapshot.docs.map((doc) {
        return BudgetModel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      setState(() {
        _budgetList = budgetList;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void _fetchCategories() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      setState(() {
        _categories = snapshot.docs
            .map((doc) => doc['category'] as String)
            .toSet()
            .toList();
      });
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  void _addCategory(String newCategory, double amount) async {
    try {
      await FirebaseFirestore.instance.collection('categories').add({
        'category': newCategory,
        'budget': amount,
      });

      if (mounted) {
        setState(() {
          _categories.add(newCategory);
        });
      }
    } catch (e) {
      print("Error adding category: $e");
    }
  }

  void _showAddCategoryForm() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => AddCategoryForm(
        onAdd: (newCategory, amount) {
          if (mounted) {
            _addCategory(newCategory, amount);
          }
        },
      ),
    );
  }

  void _showForm([BudgetModel? budgetItem]) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Input(
        budgetItem: budgetItem,
        onSave: (updatedItem) {
          if (budgetItem == null) {
            _addBudgetItem(updatedItem);
          } else {
            _updateBudgetItem(updatedItem);
          }
        },
      ),
    ).then((_) {
      _fetchBudgetData();
    });
  }

  void _addBudgetItem(BudgetModel newItem) async {
    try {
      await FirebaseFirestore.instance
          .collection('budgetData')
          .add(newItem.toMap());
    } catch (e) {
      print("Error adding budget item: $e");
    }
  }

  void _updateBudgetItem(BudgetModel updatedItem) async {
    try {
      await FirebaseFirestore.instance
          .collection('budgetData')
          .doc(updatedItem.id) // Use the document ID to update
          .update(updatedItem.toMap());
    } catch (e) {
      print("Error updating budget item: $e");
    }
  }

  void _deleteBudgetItem(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('budgetData')
          .doc(id)
          .delete();
    } catch (e) {
      print("Error deleting budget item: $e");
    }
  }

  void _onCardTap(BudgetModel budgetItem) {
    _showForm(budgetItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(0xFF055B5C),
        title: Text(
          "Budget Pro",
          style: TextStyle(
            color: Color(0xFF055B5C), // Set the color you prefer
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _showAddCategoryForm(),
            icon: const Icon(Icons.category),
          ),
          IconButton(
            onPressed: () => _showForm(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 2),
          Expanded(
            child: _budgetList.isEmpty
                ? const Center(child: Text("No budget data available."))
                : ExpenseList(
                    expenseList: _budgetList,
                    onCardTap: _onCardTap,
                    onDelete:
                        _deleteBudgetItem, // Pass the delete function here
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(), // Action for the central button
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal, // Customize color as needed
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), // Circular notch for FAB
        notchMargin: 8.0,
        child: Container(
          height: 50.0, // Height of the bottom app bar
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:budget_pro/budgetInput.dart';
// import 'package:budget_pro/budget_list.dart';
// import 'package:budget_pro/AddCategoryForm.dart';
// import 'package:budget_pro/model/model.dart';

// class Budget extends StatefulWidget {
//   const Budget({super.key});

//   @override
//   State<Budget> createState() => _BudgetState();
// }

// class _BudgetState extends State<Budget> {
//   List<BudgetModel> _budgetList = [];
//   List<String> _categories = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchBudgetData();
//     _fetchCategories();
//   }

//   void _fetchBudgetData() async {
//     try {
//       final QuerySnapshot snapshot =
//           await FirebaseFirestore.instance.collection('budgetData').get();

//       List<BudgetModel> budgetList = snapshot.docs.map((doc) {
//         return BudgetModel.fromFirestore(
//             doc.data() as Map<String, dynamic>, doc.id);
//       }).toList();

//       setState(() {
//         _budgetList = budgetList;
//       });
//     } catch (e) {
//       print("Error fetching data: $e");
//     }
//   }

//   void _fetchCategories() async {
//     try {
//       final snapshot =
//           await FirebaseFirestore.instance.collection('categories').get();
//       setState(() {
//         _categories = snapshot.docs
//             .map((doc) => doc['category'] as String)
//             .toSet()
//             .toList();
//       });
//     } catch (e) {
//       print("Error fetching categories: $e");
//     }
//   }

//   void _addCategory(String newCategory, double amount) async {
//     try {
//       await FirebaseFirestore.instance.collection('categories').add({
//         'category': newCategory,
//         'budget': amount,
//       });

//       if (mounted) {
//         setState(() {
//           _categories.add(newCategory);
//         });
//       }
//     } catch (e) {
//       print("Error adding category: $e");
//     }
//   }

//   void _showAddCategoryForm() {
//     showModalBottomSheet(
//       context: context,
//       builder: (ctx) => AddCategoryForm(
//         onAdd: (newCategory, amount) {
//           if (mounted) {
//             _addCategory(newCategory, amount);
//           }
//         },
//       ),
//     );
//   }

//   void _showForm([BudgetModel? budgetItem]) {
//     showModalBottomSheet(
//       context: context,
//       builder: (ctx) => Input(
//         budgetItem: budgetItem,
//         onSave: (updatedItem) {
//           if (budgetItem == null) {
//             _addBudgetItem(updatedItem);
//           } else {
//             _updateBudgetItem(updatedItem);
//           }
//         },
//       ),
//     ).then((_) {
//       _fetchBudgetData();
//     });
//   }

//   void _addBudgetItem(BudgetModel newItem) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('budgetData')
//           .add(newItem.toMap());
//     } catch (e) {
//       print("Error adding budget item: $e");
//     }
//   }

//   void _updateBudgetItem(BudgetModel updatedItem) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('budgetData')
//           .doc(updatedItem.id) // Use the document ID to update
//           .update(updatedItem.toMap());
//     } catch (e) {
//       print("Error updating budget item: $e");
//     }
//   }

//   void _deleteBudgetItem(String id) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('budgetData')
//           .doc(id)
//           .delete();
//     } catch (e) {
//       print("Error deleting budget item: $e");
//     }
//   }

//   void _onCardTap(BudgetModel budgetItem) {
//     _showForm(budgetItem);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         foregroundColor: Color(0xFF055B5C),
//         title: Text(
//           "Budget Pro",
//           style: TextStyle(
//             color: Color(0xFF055B5C), // Set the color you prefer
//             fontWeight: FontWeight.bold, // Make the text bold
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () => _showAddCategoryForm(),
//             icon: const Icon(Icons.category),
//           ),
//           IconButton(
//             onPressed: () => _showForm(),
//             icon: const Icon(Icons.add),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 2),
//           Expanded(
//             child: _budgetList.isEmpty
//                 ? const Center(child: Text("No budget data available."))
//                 : ExpenseList(
//                     expenseList: _budgetList,
//                     onCardTap: _onCardTap,
//                     onDelete:
//                         _deleteBudgetItem, // Pass the delete function here
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
