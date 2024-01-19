import 'package:employee/feature/employee/domain/model/employee.dart';
import 'package:employee/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmployeeEvent', () {
    test('AddEmployee should be equal and have the same hashCode', () {
      const employee1 = Employee(id: 1, name: 'John Doe');
      const employee2 = Employee(id: 1, name: 'John Doe');
      const addEmployeeEvent1 = AddEmployee(employee1);
      const addEmployeeEvent2 = AddEmployee(employee2);

      expect(addEmployeeEvent1, equals(addEmployeeEvent2));
      expect(addEmployeeEvent1.hashCode, equals(addEmployeeEvent2.hashCode));
    });

    test('UpdateEmployee should be equal and have the same hashCode', () {
      const employee1 = Employee(id: 1, name: 'John Doe');
      const employee2 = Employee(id: 1, name: 'John Doe');
      const updateEmployeeEvent1 = UpdateEmployee(employee1);
      const updateEmployeeEvent2 = UpdateEmployee(employee2);

      expect(updateEmployeeEvent1, equals(updateEmployeeEvent2));
      expect(
          updateEmployeeEvent1.hashCode, equals(updateEmployeeEvent2.hashCode));
    });

    test('DeleteEmployee should be equal and have the same hashCode', () {
      const deleteEmployeeEvent1 = DeleteEmployee(1);
      const deleteEmployeeEvent2 = DeleteEmployee(1);

      expect(deleteEmployeeEvent1, equals(deleteEmployeeEvent2));
      expect(
          deleteEmployeeEvent1.hashCode, equals(deleteEmployeeEvent2.hashCode));
    });

    test('FetchEmployees should be equal and have the same hashCode', () {
      final fetchEmployeesEvent1 = FetchEmployees();
      final fetchEmployeesEvent2 = FetchEmployees();

      expect(fetchEmployeesEvent1, equals(fetchEmployeesEvent2));
      expect(
          fetchEmployeesEvent1.hashCode, equals(fetchEmployeesEvent2.hashCode));
    });
  });
}
