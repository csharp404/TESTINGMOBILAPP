import 'package:android_projects/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat().add_yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key,required this.onAddExpense});
final void  Function(Expense expense) onAddExpense;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _title = TextEditingController();
  final _amount = TextEditingController();
  DateTime? _date;

  Category? selectedCategory = Category.food;




  void _submitDate() {
    final amout = double.tryParse(_amount.text) ?? 0;
    if (_title.text
        .trim()
        .isEmpty || amout == null || amout <= 0 || _date == null) {
      showDialog(context: context, builder: (ctx) =>
          AlertDialog(
            title: Text('Invalid Input'),
            content: Text('Please make sure the input is valid'),
            actions: [
              TextButton(onPressed: () {
                Navigator.pop(ctx);
              }, child: Text('Okay'),)
            ],
          )


      );
      return;

    }
    widget.onAddExpense(Expense(title: _title.text, amount: amout, date: _date ?? DateTime.now(), category: selectedCategory ?? Category.food));
    Navigator.pop(context);
    return;
  }
void _presentDatePicker() async {
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(
      DateTime
          .now()
          .year - 1,
      DateTime
          .now()
          .month,
      DateTime
          .now()
          .day,
    ),
    lastDate: DateTime(
      DateTime
          .now()
          .year + 1,
      DateTime
          .now()
          .month,
      DateTime
          .now()
          .day,
    ),
  );
  setState(() {
    _date = pickedDate;
  });
}

@override
void dispose() {
  _title.dispose();
  _amount.dispose();

  super.dispose();
}

@override
Widget build(context) {
  // TODO: implement build
  return Padding(
    padding: EdgeInsetsGeometry.fromLTRB(16,48,16,16),
    child: Column(
      children: [
        TextField(
          controller: _title,
          maxLength: 50,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(label: Text('Title')),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _amount,
                maxLength: 10,
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  prefixText: '\$',
                  label: Text('Amount'),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _date == null
                        ? 'no Date Selected'
                        : formatter.format(_date!),
                  ),
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ),
          ],
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: DropdownMenu<Category>(
                initialSelection: selectedCategory,

                dropdownMenuEntries: Category.values
                    .map(
                      (category) =>
                      DropdownMenuEntry(
                        value: category,
                        label: category.name.toUpperCase(),
                      ),
                )
                    .toList(),
                onSelected: (value) {
                  setState(() {
                    selectedCategory = value ;
                  });
                },
              ),
            ),

            Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _submitDate,
              child: const Text('Save Expense'),
            ),
          ],
        ),
      ],
    ),
  );
}}
