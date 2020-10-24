import 'package:expancetracker/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function detete;
  TransactionList(this.transactions, this.detete);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.6,
      child: transactions.isEmpty? Center(child: Text("No Transactions",style: Theme.of(context).textTheme.title,)) :ListView.builder(
          itemBuilder: (context,index){
            // return Card(
            //   child: Row(
            //     children: [
            //       Container(
            //         margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            //         decoration: BoxDecoration(
            //             border: Border.all(color: Theme.of(context).primaryColor,width: 2)
            //         ),
            //         padding: EdgeInsets.all(10),
            //         child: Text(
            //           '\$ ${transactions[index].amount.toStringAsFixed(2)}',
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 20,
            //               color: Theme.of(context).primaryColor,
            //           ),
            //         ),
            //       ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(transactions[index].title,style: Theme.of(context).textTheme.title,),
            //           Text(DateFormat.yMMMd().format(transactions[index].date),style: TextStyle(color: Colors.grey),)
            //         ],
            //       )
            //     ],
            //   ),
            // );
            return Card(
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(child: Text('\$${transactions[index].amount}')),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: mediaQuery.size.width > 400 ? FlatButton.icon(onPressed: () => detete(transactions[index].id), icon: Icon(Icons.delete), label: Text("Delete")) :IconButton(icon: Icon(Icons.delete),color: Colors.red,
                    onPressed: () => detete(transactions[index].id)
                  ),
                ),
              ),
            );
          },
          itemCount: transactions.length,
      ),
      // child: ListView(
      //   scrollDirection: Axis.vertical,
      //     children: transactions.map((tx){
      //       return Card(
      //         child: Row(
      //           children: [
      //             Container(
      //               margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      //               decoration: BoxDecoration(
      //                   border: Border.all(color: Colors.purple,width: 2)
      //               ),
      //               padding: EdgeInsets.all(10),
      //               child: Text(
      //                 '\$ ${tx.amount}',
      //                 style: TextStyle(
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 20,
      //                     color: Colors.purple
      //                 ),
      //               ),
      //             ),
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(tx.title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      //                 Text(DateFormat.yMMMd().format(tx.date),style: TextStyle(color: Colors.grey),)
      //               ],
      //             )
      //           ],
      //         ),
      //       );
      //     }).toList()
      // ),
    );
  }
}

