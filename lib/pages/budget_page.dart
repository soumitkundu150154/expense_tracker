import 'package:expense_tracker/models/budget_model.dart';
import 'package:expense_tracker/pages/create_budget_page.dart';
import 'package:expense_tracker/services/budget_service.dart';
import 'package:flutter/material.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  List<BudgetModel> budgets = [];

  Future<void> loadBudgets() async {
    final data = await BudgetService.getBudgets();

    setState(() {
      budgets = data;
    });
  }

  @override
  void initState() {
    super.initState();

    loadBudgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Budgets")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateBudgetPage()),
          );

          loadBudgets();
        },
      ),

      body: ListView.builder(
        itemCount: budgets.length,

        itemBuilder: (context, index) {
          final b = budgets[index];

          return Card(
            child: ListTile(
              title: Text(b.name),

              subtitle: Text("Limit ₹${b.budgetLimit.toStringAsFixed(0)}"),
            ),
          );
        },
      ),
    );
  }
}





