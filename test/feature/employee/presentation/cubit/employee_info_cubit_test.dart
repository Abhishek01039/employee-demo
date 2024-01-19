import 'package:bloc_test/bloc_test.dart';
import 'package:employee/feature/employee/domain/model/employee.dart';
import 'package:employee/feature/employee/presentation/cubit/employee_info_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmployeeInfoCubit', () {
    const initialEmployee = Employee(id: 1, name: 'John Doe', role: 'Engineer');

    blocTest<EmployeeInfoCubit, EmployeeInfoState>(
      'emits [EmployeeInfoState] when updateEmployeeName is called',
      build: () => EmployeeInfoCubit(employee: initialEmployee),
      act: (cubit) => cubit.updateEmployeeName('Jane Doe'),
      expect: () => [
        EmployeeInfoState(employee: initialEmployee.copyWith(name: 'Jane Doe'))
      ],
    );

    blocTest<EmployeeInfoCubit, EmployeeInfoState>(
      'emits [EmployeeInfoState] when updateRole is called',
      build: () => EmployeeInfoCubit(employee: initialEmployee),
      act: (cubit) => cubit.updateRole('Manager'),
      expect: () => [
        EmployeeInfoState(employee: initialEmployee.copyWith(role: 'Manager'))
      ],
    );

    blocTest<EmployeeInfoCubit, EmployeeInfoState>(
      'emits [EmployeeInfoState] when updateFromDate is called',
      build: () => EmployeeInfoCubit(employee: initialEmployee),
      act: (cubit) => cubit.updateFromDate(DateTime(2022, 1, 1)),
      expect: () => [
        EmployeeInfoState(
            employee: initialEmployee.copyWith(fromDate: DateTime(2022, 1, 1)))
      ],
    );

    blocTest<EmployeeInfoCubit, EmployeeInfoState>(
      'emits [EmployeeInfoState] when updateTempFromDate is called',
      build: () => EmployeeInfoCubit(employee: initialEmployee),
      act: (cubit) => cubit.updateTempFromDate(DateTime(2022, 1, 1)),
      expect: () => [
        EmployeeInfoState(
            employee: initialEmployee, tempFromDate: DateTime(2022, 1, 1))
      ],
    );

    blocTest<EmployeeInfoCubit, EmployeeInfoState>(
      'emits [EmployeeInfoState] when updateToDate is called',
      build: () => EmployeeInfoCubit(employee: initialEmployee),
      act: (cubit) => cubit.updateToDate(DateTime(2022, 2, 1)),
      expect: () => [
        EmployeeInfoState(
            employee: initialEmployee.copyWith(toDate: DateTime(2022, 2, 1)))
      ],
    );

    blocTest<EmployeeInfoCubit, EmployeeInfoState>(
      'emits [EmployeeInfoState] when updateTempToDate is called',
      build: () => EmployeeInfoCubit(employee: initialEmployee),
      act: (cubit) => cubit.updateTempToDate(DateTime(2022, 2, 1)),
      expect: () => [
        EmployeeInfoState(
            employee: initialEmployee, tempToDate: DateTime(2022, 2, 1))
      ],
    );

    blocTest<EmployeeInfoCubit, EmployeeInfoState>(
      'emits [EmployeeInfoState] when clearTempDate is called',
      build: () => EmployeeInfoCubit(employee: initialEmployee),
      act: (cubit) => cubit.clearTempDate(),
      expect: () => [
        EmployeeInfoState(
            employee: initialEmployee.copyWith(isToDateClear: true))
      ],
    );
  });
}
