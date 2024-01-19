import 'package:employee/feature/employee/domain/model/employee.dart';
import 'package:employee/feature/employee/presentation/cubit/employee_info_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmployeeInfoState', () {
    // Test case 1
    test('should create an instance of EmployeeInfoState', () {
      const employee = Employee(id: 1, name: 'John Doe', role: 'Developer');
      const state = EmployeeInfoState(employee: employee);

      expect(state, isA<EmployeeInfoState>());
      expect(state.employee, equals(employee));
      expect(state.tempFromDate, isNull);
      expect(state.tempToDate, isNull);
    });

    // Test case 2
    test('should copy EmployeeInfoState with updated values', () {
      const initialEmployee =
          Employee(id: 1, name: 'John Doe', role: 'Developer');
      const initialState = EmployeeInfoState(employee: initialEmployee);

      const updatedEmployee =
          Employee(id: 2, name: 'Jane Smith', role: 'Designer');
      final updatedFromDate = DateTime.now();
      final updatedToDate = DateTime.now().add(const Duration(days: 7));

      final newState = initialState.copyWith(
        employee: updatedEmployee,
        tempFromDate: updatedFromDate,
        tempToDate: updatedToDate,
      );

      expect(newState, isA<EmployeeInfoState>());
      expect(newState.employee, equals(updatedEmployee));
      expect(newState.tempFromDate, equals(updatedFromDate));
      expect(newState.tempToDate, equals(updatedToDate));
    });

    // Test case 3
    test('should copy EmployeeInfoState with tempToDate set to null', () {
      const initialEmployee =
          Employee(id: 1, name: 'John Doe', role: 'Developer');
      final initialTempToDate = DateTime.now();
      final initialState = EmployeeInfoState(
          employee: initialEmployee, tempToDate: initialTempToDate);

      final newState = initialState.copyWith(isTempToDateClear: true);

      expect(newState, isA<EmployeeInfoState>());
      expect(newState.employee, equals(initialEmployee));
      expect(newState.tempFromDate, isNull);
      expect(newState.tempToDate, isNull);
    });

    // Test case 4
    test('should be equal when two instances have the same values', () {
      const employee1 = Employee(id: 1, name: 'John Doe', role: 'Developer');
      final state1 = EmployeeInfoState(
          employee: employee1,
          tempFromDate: DateTime(2022, 1, 1),
          tempToDate: DateTime(2022, 1, 7));

      const employee2 = Employee(id: 1, name: 'John Doe', role: 'Developer');
      final state2 = EmployeeInfoState(
          employee: employee2,
          tempFromDate: DateTime(2022, 1, 1),
          tempToDate: DateTime(2022, 1, 7));

      expect(state1, equals(state2));
    });
  });
}
