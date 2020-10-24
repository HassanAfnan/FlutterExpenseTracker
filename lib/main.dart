import 'dart:io';

import 'package:expancetracker/Transaction.dart';
import 'package:expancetracker/chart.dart';
import 'package:expancetracker/new_transaction.dart';
import 'package:expancetracker/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expanse Tracker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
          textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
        )
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> transactions = [
  ];

  List<Transaction> get _recentTransaction{
    return transactions.where((element){
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate){
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: chosenDate,
        id: DateTime.now().toString()
    );

    setState(() {
      transactions.add(newTx);
    });
  }

  void startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return NewTransaction(addTx: _addNewTransaction);
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      transactions.removeWhere((element){
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Used to find out that the device is landscape or portraid
   final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final appBarWidget = Platform.isIOS ? CupertinoNavigationBar(
      middle: Text("Expense Tracker"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => startAddNewTransaction(context),
          )
        ],
      ),
    ) : AppBar(
      title: Text("Expanse Tracker"),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startAddNewTransaction(context),
        )
      ],
    );
   final bodyPart = SafeArea(child: Column(
     crossAxisAlignment: CrossAxisAlignment.stretch,
     children: [
       Container(
           height: MediaQuery.of(context).size.height * 0.3,
           child: Chart(recentTransactions: _recentTransaction,)),
       TransactionList(transactions,_deleteTransaction),
     ],
   ),);
   //we can do same for material app with cupertino app

   return Platform.isIOS ? CupertinoPageScaffold(
     child: bodyPart,
     navigationBar: appBarWidget,
   ) :Scaffold(
      appBar: appBarWidget,
      body: bodyPart,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}



