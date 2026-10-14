import 'package:android_projects/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(context) {
    return Card(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
      child: Column(
        children: [
          Text(expense.title),
          SizedBox(height: 4,),
          Row(
            children: [
              Text('\$${expense.amount.toStringAsFixed(2)}'),
              Spacer(),
              Row(
                children: [
                  Icon(expense.getIconCategory),
                  SizedBox(width: 8,),
                  Text(expense.getFormattedDate)
                ],
              )
            ],
          )
        ],
      ),
    ));
  }
}
