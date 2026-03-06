import 'package:expense_tracker/models/transaction_model.dart';
import 'package:expense_tracker/models/transaction_type.dart';
import 'package:expense_tracker/services/transaction_service.dart';
import 'package:expense_tracker/theme/deep_finance.dart';
import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  List<TransactionModel> transactions = [];

  Future<void> loadTransactions() async {
    final data = await TransactionService.getTransactions();

    setState(() {
      transactions = data;
    });
  }

  Future<void> deleteTransaction(String id) async {
    await TransactionService.deleteTransaction(id);

    loadTransactions();
  }

  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transaction History")),

      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16, 4, 16, 100),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final t = transactions[index];
          final isExpense = t.type == TransactionType.expense;

          return Dismissible(
            key: Key(t.id),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              deleteTransaction(t.id);
            },

            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: Card(
              child: ListTile(
                leading: Icon(
                  isExpense ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isExpense ? AppTheme.expense : AppTheme.income,
                ),

                title: Text(t.category),

                subtitle: Text(t.note),

                trailing: Text(
                  "${isExpense ? "-" : "+"} ₹${t.amount}",
                  style: TextStyle(
                    color: isExpense ? AppTheme.expense : AppTheme.income,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
