import 'package:expense_tracker/pages/transaction_page.dart';
import 'package:expense_tracker/theme/deep_finance.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
      appBar: AppBar(title: Text('Dashboard'), elevation: 0),

      // floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // greeting
            const Text(
              'Hello, Soumit',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // balance card
            _balanceCard(),

            // Monthly summary card
            _summaryRow(),

            // Quick add transaction
            _quickAddCard(context),

            //recent Transcation list
            const Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _transactionTile(
              title: "Lunch",
              amount: "- ₹250",
              color: AppTheme.danger,
            ),

            _transactionTile(
              title: "Freelance Payment",
              amount: "+ ₹5000",
              color: AppTheme.success,
            ),
          ],
        ),
      ),
    );
  }
}

// Balance card
Widget _balanceCard() {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: AppTheme.balanceGradient,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Current Balance", style: TextStyle(color: Colors.white70)),

        const SizedBox(height: 8),

        Text(
          "₹ 24,500",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        SizedBox(height: 8),

        Text("+ ₹1,200 this month", style: TextStyle(color: Colors.white70)),
      ],
    ),
  );
}

// summary row

Widget _summaryRow() {
  return Row(
    children: [
      Expanded(
        child: _summaryCard(
          title: "Income",
          amount: "₹10,000",
          color: AppTheme.success,
        ),
      ),

      const SizedBox(width: 12),

      Expanded(
        child: _summaryCard(
          title: "Expense",
          amount: "₹6,200",
          color: AppTheme.danger,
        ),
      ),

      const SizedBox(width: 12),

      Expanded(
        child: _summaryCard(
          title: "Net",
          amount: "₹3,800",
          color: AppTheme.primaryAccent,
        ),
      ),
    ],
  );
}

// summary card
Widget _summaryCard({
  required String title,
  required String amount,
  required Color color,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),

          const SizedBox(height: 6),

          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}

// quick add card
// quick add card
Widget _quickAddCard(BuildContext context) {
  return Card(
    child: ListTile(
      leading: const Icon(Icons.add_circle_outline),
      title: const Text("Add Transaction"),
      subtitle: const Text("Record income or expense"),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddTransactionPage(),
          ),
        );
      },
    ),
  );
}

// transcation tile

Widget _transactionTile({
  required String title,
  required String amount,
  required Color color,
}) {
  return Card(
    child: ListTile(
      leading: const Icon(Icons.account_balance_wallet),
      title: Text(title),
      trailing: Text(
        amount,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
