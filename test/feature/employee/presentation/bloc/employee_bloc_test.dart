import 'package:bloc_test/bloc_test.dart';
import 'package:employee/feature/employee/domain/model/employee.dart';
import 'package:employee/feature/employee/domain/repository/employee_repo.dart';
import 'package:employee/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEmployeeRepo extends Mock implements EmployeeRepo {}

class MyTypeFake extends Fake implements Employee {}

void main() {
  group('EmployeeBloc', () {
    late EmployeeRepo mockEmployeeRepo;
    late EmployeeBloc employeeBloc;
    final List<Employee> employee = [
      Employee(
        id: 1,
        name: 'John Doe',
        role: 'Engineer',
        fromDate: DateTime(2022, 1, 1),
      ),
      Employee(
        id: 2,
        name: 'Jane Doe',
        role: 'Manager',
        fromDate: DateTime(2022, 2, 1),
        toDate: DateTime(2022, 3, 1),
      ),
    ];
    final List<Employee> currentEmployee = [employee[0]];
    final List<Employee> previousEmployee = [employee[1]];

    setUp(() {
      mockEmployeeRepo = MockEmployeeRepo();
      employeeBloc = EmployeeBloc(employeeRepo: mockEmployeeRepo);
      registerFallbackValue(MyTypeFake());
    });

    tearDown(() {
      employeeBloc.close();
    });

    test('initial state is EmployeeInitial', () {
      expect(employeeBloc.state, equals(EmployeeInitial()));
    });

    blocTest<EmployeeBloc, EmployeeState>(
      'emits [EmployeeLoading, EmployeeSuccess] when AddEmployee is added',
      build: () {
        when(() => mockEmployeeRepo.createEmployee(any()))
            .thenAnswer((_) async {});
        when(() => mockEmployeeRepo.getAllEmployees())
            .thenAnswer((_) => employee);
        return employeeBloc;
      },
      act: (bloc) =>
          bloc.add(const AddEmployee(Employee(id: 1, name: 'John Doe'))),
      expect: () => [
        EmployeeLoading(),
        const EmployeeSuccess('Employee Added'),
        EmployeeLoading(),
        EmployeeLoaded(currentEmployee, previousEmployee),
      ],
    );

    blocTest<EmployeeBloc, EmployeeState>(
      'emits [EmployeeLoading, EmployeeError] when AddEmployee throws an error',
      build: () {
        when(() => mockEmployeeRepo.createEmployee(any()))
            .thenThrow('something went wrong');
        return employeeBloc;
      },
      act: (bloc) =>
          bloc.add(const AddEmployee(Employee(id: 1, name: 'John Doe'))),
      expect: () =>
          [EmployeeLoading(), const EmployeeError('something went wrong')],
    );

    blocTest<EmployeeBloc, EmployeeState>(
      'emits [EmployeeLoading, EmployeeLoaded] when FetchEmployees is added',
      build: () {
        final employees = [
          const Employee(id: 1, name: 'John Doe', toDate: null)
        ];
        when(() => mockEmployeeRepo.getAllEmployees()).thenReturn(employees);
        return employeeBloc;
      },
      act: (bloc) => bloc.add(FetchEmployees()),
      expect: () => [
        EmployeeLoading(),
        const EmployeeLoaded(
            [Employee(id: 1, name: 'John Doe', toDate: null)], []),
      ],
    );

    blocTest<EmployeeBloc, EmployeeState>(
      'emits [EmployeeLoading, EmployeeSuccess] when UpdateEmployee is added',
      build: () {
        when(() => mockEmployeeRepo.updateEmployee(any()))
            .thenAnswer((_) async => currentEmployee[0]);
        when(() => mockEmployeeRepo.getAllEmployees())
            .thenAnswer((_) => employee);
        return employeeBloc;
      },
      act: (bloc) {
        bloc.add(
            const UpdateEmployee(Employee(id: 1, name: 'Updated John Doe')));
      },
      expect: () => [
        EmployeeLoading(),
        const EmployeeSuccess('Employee Updated'),
        EmployeeLoading(),
        EmployeeLoaded(currentEmployee, previousEmployee),
      ],
    );

    blocTest<EmployeeBloc, EmployeeState>(
      'emits [EmployeeLoading, EmployeeError] when UpdateEmployee throws an error',
      build: () {
        when(() => mockEmployeeRepo.updateEmployee(any()))
            .thenThrow('Update error');
        return employeeBloc;
      },
      act: (bloc) async {
        bloc.add(
            const UpdateEmployee(Employee(id: 1, name: 'Updated John Doe')));
      },
      expect: () => [EmployeeLoading(), const EmployeeError('Update error')],
    );

    blocTest<EmployeeBloc, EmployeeState>(
      'emits [EmployeeLoading, EmployeeSuccess] when DeleteEmployee is added',
      build: () {
        when(() => mockEmployeeRepo.deleteEmployee(any()))
            .thenAnswer((_) async {});
        when(() => mockEmployeeRepo.getAllEmployees())
            .thenAnswer((_) => employee);
        return employeeBloc;
      },
      act: (bloc) async {
        bloc.add(const DeleteEmployee(1));
      },
      expect: () => [
        EmployeeLoading(),
        const EmployeeSuccess('Employee Deleted'),
        EmployeeLoading(),
        EmployeeLoaded(currentEmployee, previousEmployee),
      ],
    );

    blocTest<EmployeeBloc, EmployeeState>(
      'emits [EmployeeLoading, EmployeeError] when DeleteEmployee throws an error',
      build: () {
        when(() => mockEmployeeRepo.deleteEmployee(any()))
            .thenThrow('Delete error');
        return employeeBloc;
      },
      act: (bloc) async {
        bloc.add(const DeleteEmployee(1));
      },
      expect: () => [EmployeeLoading(), const EmployeeError('Delete error')],
    );
  });
}
