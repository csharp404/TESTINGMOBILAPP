import 'package:android_projects/widgets/expenses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(

    theme: ThemeData().copyWith(
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.redAccent

    ),
    debugShowCheckedModeBanner: false,
    home:Expenses() ,
  ));
}