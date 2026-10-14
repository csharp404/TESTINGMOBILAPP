import 'package:android_projects/models/expense.dart';
import 'package:android_projects/widgets/expenses%20list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.expenses,this.onRemoveExpense, {super.key});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) =>Dismissible(
        key: ValueKey(expenses[index]),

        direction: DismissDirection.horizontal,

        background: Container(
          color: Colors.red,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),

        secondaryBackground: Container(
          color: Colors.blue,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),

        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            // Edit
            print('Edit clicked');

            // Don't actually dismiss the item
            return false;
          }

          // Delete
          return true;
        },

        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },

        child: ExpenseItem(expenses[index]),
      )
    );
  }
}
