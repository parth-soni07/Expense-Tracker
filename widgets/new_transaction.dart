import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    // now first we need to add titlecontroler and amountControler so that the submit button doesnot work if any of the entry is missing
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePiceker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2005),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(label: Text('Name of Purchase :')),
              controller: titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => submitData(),
              // _ defines that the programmer doesn't care about the value given to the function
            ),
            TextField(
              decoration: InputDecoration(label: Text('Amount :')),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              // onChanged: (value) {
              //   amountInput = value;
              // }
            ),
            Container(
              height: 50,
              child: Row(children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.cyan)),
                  child: Text(
                    'Choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    _presentDatePiceker();
                  },
                )
              ]),
            ),
            ElevatedButton(
              child: Text('Add Transaction'),
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
