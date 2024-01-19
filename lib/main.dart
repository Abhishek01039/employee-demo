import 'package:employee/app.dart';
import 'package:employee/feature/employee/domain/model/employee.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeAdapter());
  await Hive.openBox<Employee>('employee');

  runApp(const EmployeeApp());
}
