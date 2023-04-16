import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No Transactions!!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.7,
                    child: Image.asset(
                      'images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: ListTile(
                    leading: Container(
                      height: 60,
                      child: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: FittedBox(
                              child: Text('\₹${transactions[index].amount}'),
                            ),
                          )),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        '${DateFormat.yMMMd().format(transactions[index].date)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
