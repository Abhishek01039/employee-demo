import 'package:employee/feature/employee/domain/model/employee.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EmployeeCRUD {
  EmployeeCRUD({Box<Employee>? box})
      : _box = box ?? Hive.box<Employee>('employee');

  final Box<Employee> _box;

  Future<void> createEmployee(Employee employee) async {
    final id = _box.values.length + 1;
    await _box.put(id, employee.copyWith(id: id));
  }

  Future<void> deleteEmployee(int index) async {
    await _box.delete(index);
  }

  List<Employee> getAllEmployees() {
    return _box.values.toList();
  }

  Future<void> updateEmployee(Employee employee) async {
    await _box.put(employee.id!, employee);
  }
}
