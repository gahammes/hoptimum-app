import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class NewLog extends StatefulWidget {
  final Function addTx;

  NewLog(this.addTx);

  @override
  State<NewLog> createState() => _NewLog();
}

class _NewLog extends State<NewLog> {
  final _titleController = TextEditingController();
  final _placaController = TextEditingController();
  final _tagController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    if (_placaController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = _placaController.text;
    final enteredTag = _tagController.text;

    if (enteredTitle.isEmpty ||
        enteredAmount.isEmpty ||
        _selectedDate == null ||
        enteredTag.isEmpty) {
      return;
    }

    widget.addTx(
      _titleController.text,
      _placaController.text,
      _selectedDate,
      _tagController.text,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
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
    initializeDateFormatting('pt_BR', null);
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (value) {
                //   titleInput = value;
                // },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Placa',
                ),
                controller: _placaController,

                onSubmitted: (_) => _submitData(),
                // onChanged: (value) {
                //   amountInput = value;
                // },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Tag',
                ),
                controller: _tagController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (value) {
                //   amountInput = value;
                // },
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen'
                            : 'Picked date: ${DateFormat.yMd('pt_BR').format(_selectedDate)}',
                      ),
                    ),
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
