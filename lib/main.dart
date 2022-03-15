// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oooo/Widgets/chart.dart';
import 'Widgets/llist_transactions.dart';
import 'Widgets/new_transactions.dart';
import 'models/transaction.dart';
import 'Widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Quicksand',
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.normal),
          )),
      title: 'Flutter App',
      home: MyHomePage(),
      color: Colors.green[700],
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime choosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: choosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTr(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'MY EXPENSES',
        ),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTr(context),
            icon: Icon(
              Icons.add,
              size: 26,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        splashColor: Colors.lightGreen,
        backgroundColor: Colors.green[400],
        onPressed: () => _startAddNewTr(context),
      ),
    );
  }
}
