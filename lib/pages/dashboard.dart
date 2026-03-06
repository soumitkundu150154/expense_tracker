import 'package:expense_tracker/models/transaction_model.dart';
import 'package:expense_tracker/models/transaction_type.dart';
import 'package:expense_tracker/pages/budget_page.dart';
import 'package:expense_tracker/pages/transaction_history.dart';
import 'package:expense_tracker/pages/transaction_page.dart';
import 'package:expense_tracker/services/transaction_service.dart';
// import 'package:expense_tracker/theme/app_theme.dart';
import 'package:expense_tracker/theme/deep_finance.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String userName = "";
  List<TransactionModel> transactions = [];
  double currentBalance = 0;
  double initialBalance = 0;
  double totalIncome = 0;
  double totalExpense = 0;
  double netBalance = 0;

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString("user_name") ?? "";
      initialBalance = prefs.getDouble("initial_balance") ?? 0;
    });
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour > 4 && hour < 12)
      return "Good Morning";
    else if (hour > 12 && hour < 17)
      return "Good Afternoon";
    else
      return "Good Evening";
  }

  Future<void> loadData() async {
    final txns = await TransactionService.getTransactions();
    final balance = await TransactionService.calculateBalance(initialBalance);
    double income = 0;
    double expense = 0;
    for (var t in txns) {
      if (t.type == TransactionType.income)
        income += t.amount;
      else
        expense += t.amount;
    }
    setState(() {
      transactions = txns;
      currentBalance = balance;
      totalIncome = income;
      totalExpense = expense;
      netBalance = income - expense;
    });
  }

  @override
  void initState() {
    super.initState();
    initializedashboard();
  }

  Future<void> initializedashboard() async {
    await loadUserData();
    await loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppTheme.primaryDim,
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                style: const TextStyle(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTransactionPage()),
          );
          loadData();
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${getGreeting()},\n',
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppTheme.textSecondary,
                      height: 2,
                    ),
                  ),
                  TextSpan(
                    text: '$userName 👋',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _balanceCard(currentBalance),
            const SizedBox(height: 14),
            _summaryRow(totalIncome, totalExpense, netBalance),
            const SizedBox(height: 14),
            _quickAddCard(context),
            const SizedBox(height: 28),
            _budgetCard(context),
            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionHistoryPage(),
                      ),
                    );
                  },
                  child: Text(
                    '${transactions.length} total',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            transactions.isEmpty
                ? _emptyState()
                : Column(
                    children: transactions.take(5).map((t) {
                      final isExpense = t.type == TransactionType.expense;
                      return _transactionCard(t, isExpense);
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _transactionCard(TransactionModel t, bool isExpense) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border),
        boxShadow: AppTheme.cardShadow,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: isExpense ? AppTheme.expenseDim : AppTheme.incomeDim,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            isExpense
                ? Icons.arrow_downward_rounded
                : Icons.arrow_upward_rounded,
            color: isExpense ? AppTheme.expense : AppTheme.income,
            size: 20,
          ),
        ),
        title: Text(
          t.category,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: AppTheme.textPrimary,
          ),
        ),
        subtitle: Text(
          t.note,
          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
        ),
        trailing: Text(
          "${isExpense ? "−" : "+"} ₹${t.amount.toStringAsFixed(2)}",
          style: TextStyle(
            color: isExpense ? AppTheme.expense : AppTheme.income,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _emptyState() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 52,
              color: AppTheme.textMuted,
            ),
            SizedBox(height: 12),
            Text(
              'No transactions yet',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Balance Card ──────────────────────────────────────────────────────────────
 
Widget _balanceCard(dynamic currentBalance) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: AppTheme.balanceGradient,
      borderRadius: BorderRadius.circular(20),
      boxShadow: AppTheme.primaryGlow,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              color: Colors.white70,
              size: 16,
            ),
            SizedBox(width: 6),
            Text(
              "Current Balance",
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "₹ ${currentBalance.toStringAsFixed(2)}",
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            "+ ₹1,200 this month",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

// ── Summary Row ───────────────────────────────────────────────────────────────

Widget _summaryRow(double income, double expense, double net) {
  return Row(
    children: [
      Expanded(
        child: _summaryCard(
          title: "Income",
          amount: "₹${income.toStringAsFixed(0)}",
          color: AppTheme.income,
          icon: Icons.trending_up_rounded,
          dimColor: AppTheme.incomeDim,
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: _summaryCard(
          title: "Expense",
          amount: "₹${expense.toStringAsFixed(0)}",
          color: AppTheme.expense,
          icon: Icons.trending_down_rounded,
          dimColor: AppTheme.expenseDim,
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: _summaryCard(
          title: "Net",
          amount: "₹${net.toStringAsFixed(0)}",
          color: AppTheme.primary,
          icon: Icons.balance_rounded,
          dimColor: AppTheme.primaryDim,
        ),
      ),
    ],
  );
}

Widget _summaryCard({
  required String title,
  required String amount,
  required Color color,
  required IconData icon,
  required Color dimColor,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
    decoration: BoxDecoration(
      color: AppTheme.surface,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: AppTheme.border),
      boxShadow: AppTheme.cardShadow,
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: dimColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary),
        ),
        const SizedBox(height: 4),
        FittedBox(
          child: Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

// ── Quick Add Card ────────────────────────────────────────────────────────────

Widget _quickAddCard(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTransactionPage()),
    ),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.primary.withOpacity(0.3)),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryDim,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.add_circle_outline_rounded,
              color: AppTheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Transaction",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppTheme.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "Record income or expense",
                  style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: AppTheme.textMuted,
          ),
        ],
      ),
    ),
  );
}

Widget _budgetCard(BuildContext context) {
  return Card(
    child: ListTile(
      leading: const Icon(Icons.account_balance),
      title: const Text("Budgets"),
      subtitle: const Text("Manage your budgets"),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BudgetPage()),
        );
      },
    ),
  );
}
