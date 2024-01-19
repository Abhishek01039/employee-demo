// employee_model.dart

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'employee.g.dart';

@HiveType(typeId: 0)
class Employee extends Equatable {
  const Employee({
    this.id,
    this.name,
    this.role,
    this.fromDate,
    this.toDate,
  });

  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? role;

  @HiveField(3)
  final DateTime? fromDate;

  @HiveField(4)
  final DateTime? toDate;

  Employee copyWith({
    int? id,
    String? name,
    String? role,
    DateTime? fromDate,
    DateTime? toDate,
    bool isToDateClear = false,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      fromDate: fromDate ?? this.fromDate,
      toDate: isToDateClear ? null : toDate ?? this.toDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        role,
        fromDate,
        toDate,
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'fromDate': fromDate?.toIso8601String(),
      'toDate': toDate?.toIso8601String(),
    };
  }
}
