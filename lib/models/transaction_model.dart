import 'transaction_type.dart';

class TransactionModel {
  final String id;
  final double amount;
  final TransactionType type;
  final String category;
  final String note;
  final String paymentMethod;
  final DateTime date;
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.type,
    required this.category,
    required this.note,
    required this.paymentMethod,
    required this.date,
    required this.createdAt,
  });

  // convert object -> Map (for database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'type': type,
      'category': category,
      'note': note,
      'paymentMethod': paymentMethod,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Convert Map -> Object
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      amount: map['amount'],
      type: map['type'] == 'income' ? TransactionType.income : TransactionType.expense,
      category: map['category'],
      note: map['note'],
      paymentMethod: map['paymentMethod'],
      date: DateTime.parse(map['date']),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}