class BudgetModel {
  final String id;
  final String name;
  final String note;
  final double budgetLimit;
  final DateTime createdAt;
  

  BudgetModel({
    required this.id,
    required this.createdAt,
    required this.note,
    required this.name,
    required this.budgetLimit,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'limit': budgetLimit,
      'createdAt': createdAt.toIso8601String(),
      'note': note,
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['id'],
      createdAt: DateTime.parse(map['createdAt']),
      name: map['name'],
      budgetLimit: map['budgetLimit'],
      note: map['note'],
    );
  }
}
