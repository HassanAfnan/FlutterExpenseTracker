import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction({Key key, this.addTx}) : super(key: key);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _seletedDate;

  void submitData(){
    if(amountController.text.isEmpty){
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if(enteredTitle.isEmpty || enteredAmount <= 0 || _seletedDate == null){
      return;
    }
    widget.addTx(enteredTitle,enteredAmount,_seletedDate);
    Navigator.of(context).pop();
  }

  void presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
    ).then((value){
      if(value == null){
        return;
      }
      setState(() {
        _seletedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                  labelText: "Title"
              ),
              // onChanged: (value){
              //   title = value;
              // },
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Amount"
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              // onChanged: (value){
              //    amount = value;
              // },
              controller: amountController,
            ),
            Row(
              children: [
                Text(_seletedDate == null ? 'No Date Chosen': DateFormat.yMd().format(_seletedDate)),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text('Choose Date',style: TextStyle(fontWeight: FontWeight.bold),),
                  onPressed: presentDatePicker,
                ),
              ],
            ),
            RaisedButton(
              child: Text("Add Transaction"),
              textColor: Theme.of(context).primaryColor,
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}


