import 'package:expense_tracker/models/transaction_model.dart';
import 'package:expense_tracker/models/transaction_type.dart';
import 'package:expense_tracker/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  TransactionType _selectedType = TransactionType.expense;

  String _selectedCategory = "Food";
  String _selectedPayment = "UPI";

  DateTime _selectedDate = DateTime.now();

  final uuid = const Uuid();

  final List<String> categories = [
    "Food",
    "Travel",
    "Shopping",
    "Subscription",
    "Salary",
    "Other",
  ];

  final List<String> paymentMethods = ["UPI", "Cash", "Card", "Bank Transfer"];

  Future<void> _saveTransaction() async {
    if (_amountController.text.isEmpty) {
      return;
    }
    final amount = double.parse(_amountController.text);

    final transaction = TransactionModel(
      id: uuid.v4(),
      amount: amount,
      type: _selectedType,
      category: _selectedCategory,
      note: _noteController.text,
      paymentMethod: _selectedPayment,
      date: _selectedDate,
      createdAt: DateTime.now(),
    );

    await TransactionService.addTransaction(transaction);

    Navigator.pop(context);
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Transaction")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // amount
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
                prefixText: "₹ ",
              ),
            ),

            const SizedBox(height: 16),

            /// transaction type
            SegmentedButton<TransactionType>(
              segments: const [
                ButtonSegment(
                  value: TransactionType.expense,
                  label: Text("Expense"),
                ),
                ButtonSegment(
                  value: TransactionType.income,
                  label: Text("Income"),
                ),
              ],
              selected: {_selectedType},
              onSelectionChanged: (value) {
                setState(() {
                  _selectedType = value.first;
                });
              },
            ),

            const SizedBox(height: 16),

            // Category DropDown
            DropdownButtonFormField(
              initialValue: _selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
              decoration: const InputDecoration(labelText: "Category"),
            ),

            const SizedBox(height: 16),

            /// payment method
            DropdownButtonFormField(
              initialValue: _selectedPayment,
              items: paymentMethods.map((method) {
                return DropdownMenuItem(value: method, child: Text(method));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPayment = value!;
                });
              },
              decoration: const InputDecoration(labelText: "Payment Method"),
            ),

            const SizedBox(height: 16),

            /// note
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: "Note"),
            ),

            /// Date picker
            ListTile(
              title: const Text("Transaction Date"),
              subtitle: Text(
                "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),

            /// save button
            ElevatedButton(
              onPressed: _saveTransaction,
              child: const Text("Save Transaction"),
            ),
          ],
        ),
      ),
    );
  }
}
