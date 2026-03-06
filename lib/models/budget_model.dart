class BudgetModel {
  final String id;
  final String name;
  final double limit;
  final DateTime createdAt;

  BudgetModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.limit,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'limit': limit,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['id'],
      createdAt: DateTime.parse(map['createdAt']),
      name: map['name'],
      limit: map['limit'],
    );
  }
}






