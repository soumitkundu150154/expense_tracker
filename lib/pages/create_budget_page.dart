import 'package:expense_tracker/models/budget_model.dart';
import 'package:expense_tracker/services/budget_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CreateBudgetPage extends StatefulWidget {
  const CreateBudgetPage({super.key});

  @override
  State<CreateBudgetPage> createState() => _CreateBudgetPageState();
}

class _CreateBudgetPageState extends State<CreateBudgetPage> {
  final nameController = TextEditingController();
  final limitController = TextEditingController();
  final noteController = TextEditingController();

  final uuid = const Uuid();
  Future<void> saveBudget() async {
    final budget = BudgetModel(
      id: uuid.v4(),
      createdAt: DateTime.now(),
      name: nameController.text,
      budgetLimit: double.parse(limitController.text),
      note: noteController.text,
    );

    await BudgetService.addBudget(budget);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Budget')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: limitController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Budget Limit",
                prefixText: "₹",
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: noteController,
              decoration: const InputDecoration(labelText: "Note"),
            ),

            const SizedBox(height: 30),

            ElevatedButton(onPressed: saveBudget, child: Text("Create Budget")),
          ],
        ),
      ),
    );
  }
}
