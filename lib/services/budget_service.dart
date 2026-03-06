import 'package:expense_tracker/models/budget_model.dart';
import 'package:expense_tracker/services/transaction_service.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

class BudgetService {
  /// Add budget
  static Future<void> addBudget(BudgetModel budget) async {
    final db = await TransactionService.database;

    await db?.insert(
      'budgets',
      {
        "id": budget.id,
        "name": budget.name,
        "budgetLimit": budget.budgetLimit,
        "createdAt": budget.createdAt.toIso8601String(),
        "note": budget.note,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get all budgets
  static Future<List<BudgetModel>> getBudgets() async {
    final db = await TransactionService.database;

    final List<Map<String, Object?>>? maps = await db?.query('budgets');

    return List.generate(maps!.length, (i) {
      return BudgetModel.fromMap(maps[i]);
    });
  }

  /// delete budget
  static Future<void> deleteBudget(String id) async {
    final db = await TransactionService.database;

    await db?.delete(
      'budgets',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
