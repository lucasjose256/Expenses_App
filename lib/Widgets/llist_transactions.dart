import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  Function deleteCard;
  TransactionList(this.transaction, this.deleteCard);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: transaction.isEmpty
          ? Column(
              children: [
                Text(
                  'No Transaction!',
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'Assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red[300],
                      onPressed: () => deleteCard(transaction[index].id),
                    ),
                    leading: CircleAvatar(
                      radius: 50,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                          child: Text('\$${transaction[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transaction[index].title,
                      style: TextStyle(fontSize: 22),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transaction[index].date),
                    ),
                  ),
                );
              },
              itemCount: transaction.length,
            ),
    );
  }
}
