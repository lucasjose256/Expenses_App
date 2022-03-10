import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function f;

  NewTransaction(this.f);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  DateTime _timecontroler;
  final _amountController = TextEditingController();

  void _subimt() {
    final titleTex = _titleController.text;
    final amountTex = double.parse(_amountController.text);

    if (titleTex.isEmpty || amountTex <= 0) {
      return;
    }
    widget.f(titleTex, amountTex);
    Navigator.of(context).pop();
  }

  void _presentDaydatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _timecontroler = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              cursorColor: Colors.teal[900],
              controller: _titleController,
              onSubmitted: (_) => _subimt(),
            ),
            TextField(
              cursorColor: Colors.teal[900],
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _subimt(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Text(_timecontroler == null
                      ? 'No date Chosen'
                      : DateFormat.yMd().format(_timecontroler)),
                  FlatButton(
                      onPressed: _presentDaydatePicker,
                      child: Text(
                        'Choose date',
                        style: TextStyle(
                            color: Colors.green[900],
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),

            // ignore: deprecated_member_use
            FlatButton(
              onPressed: _subimt,
              child: const Text(
                'Add transaction',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              color: Colors.green[600],
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
