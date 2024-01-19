import 'package:employee/feature/employee/domain/model/employee.dart';
import 'package:employee/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmployeeState', () {
    test('EmployeeInitial should be equal and have the same hashCode', () {
      final employeeInitial1 = EmployeeInitial();
      final employeeInitial2 = EmployeeInitial();

      expect(employeeInitial1, equals(employeeInitial2));
      expect(employeeInitial1.hashCode, equals(employeeInitial2.hashCode));
    });

    test('EmployeeLoading should be equal and have the same hashCode', () {
      final employeeLoading1 = EmployeeLoading();
      final employeeLoading2 = EmployeeLoading();

      expect(employeeLoading1, equals(employeeLoading2));
      expect(employeeLoading1.hashCode, equals(employeeLoading2.hashCode));
    });

    test('EmployeeSuccess should be equal and have the same hashCode', () {
      const successMessage = 'Operation successful';
      const employeeSuccess1 = EmployeeSuccess(successMessage);
      const employeeSuccess2 = EmployeeSuccess(successMessage);

      expect(employeeSuccess1, equals(employeeSuccess2));
      expect(employeeSuccess1.hashCode, equals(employeeSuccess2.hashCode));
    });

    test('EmployeeLoaded should be equal and have the same hashCode', () {
      final currentEmployees = [const Employee(id: 1, name: 'John Doe')];
      final List<Employee> previousEmployees = [];
      final employeeLoaded1 =
          EmployeeLoaded(currentEmployees, previousEmployees);
      final employeeLoaded2 =
          EmployeeLoaded(currentEmployees, previousEmployees);

      expect(employeeLoaded1, equals(employeeLoaded2));
      expect(employeeLoaded1.hashCode, equals(employeeLoaded2.hashCode));
    });

    test('EmployeeError should be equal and have the same hashCode', () {
      const errorMessage = 'Error occurred';
      const employeeError1 = EmployeeError(errorMessage);
      const employeeError2 = EmployeeError(errorMessage);

      expect(employeeError1, equals(employeeError2));
      expect(employeeError1.hashCode, equals(employeeError2.hashCode));
    });
  });
}
