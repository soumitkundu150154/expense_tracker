import 'package:flutter/painting.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/transaction_model.dart';
import '../models/transaction_type.dart';

class TransactionService {
  static Database? _database;

  /// initialize database
  static Future<Database?> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database;
  }

  /// Create database
  static Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'expense_tracker.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE transactions(
          id TEXT PRIMARY KEY,
          amount REAL,
          type TEXT,
          category TEXT,
          paymentMethod TEXT,
          date TEXT,
          createdAt TEXT,
          )
          ''');
      },
    );
  }

  /// Add transaction
  static Future<void> addTransaction(TransactionModel transaction) async {
    final db = await database;

    await db?.insert(
      'transaction',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// get all transactions
  static Future<List<TransactionModel>> getTransactions() async {
    final db = await database;

    final List<Map<String, Object?>>? maps = await db?.query(
      'transactions',
      orderBy: 'date DESC',
    );
    return List.generate(maps!.length, (i) {
      return TransactionModel.fromMap(maps[i]);
    });
  }

  /// delete transactions
  static Future<void> deleteTransaction(String id) async {
    final db = await database;

    await db?.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  /// calculate current balance
  static Future<double> calculateBalance(double initialBalance) async {
    final transactions = await getTransactions();

    double income = 0;
    double expense = 0;

    for (var t in transactions) {
      if (t.type == TransactionType.income) {
        income += t.amount;
      } else {
        expense += t.amount;
      }
    }

    return initialBalance + income - expense;
  }
}






