import 'dart:math';

import 'package:android_projects/expenses_list.dart';
import 'package:android_projects/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
   return _ExpensesState();
  }

}
class _ExpensesState extends State<Expenses>{

  final List<Expense> _registeredExpenses = [

    Expense(title: 'yousef', amount: 15.6, date: DateTime.now(), category: Category.work),
    Expense(title: 'samer', amount: 18.8, date: DateTime.now(), category: Category.food),

  ];
  void _openAddExpenseOverlay(){
    showModalBottomSheet(isScrollControlled: true,context: context, builder: (ctx)=> NewExpense(onAddExpense: _addExpense,));
  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }
  void _removeExpense(Expense expense){
   final idx = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Deleted'),
          duration:Duration(seconds: 3),
          action: SnackBarAction(label: 'Undo', onPressed: (){
      setState(() {
        _registeredExpenses.insert(idx, expense);
      });
    }),));
  }
  @override
  Widget build( context) {
    Widget mainContent = Center(child: Text('No Expenses Found'),);
    if(_registeredExpenses.isNotEmpty){
      mainContent = ExpensesList(_registeredExpenses,_removeExpense);
    }
return Scaffold(
  appBar: AppBar(
    title: Text('Flutter Expenses Tracker'),
    backgroundColor: Colors.red,
    actions: [
      IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add))
    ],
  ),
  body: Column(
    children: [
      Text('Header'),
      Expanded(child: mainContent)

    ],
  ),
);
  }

}