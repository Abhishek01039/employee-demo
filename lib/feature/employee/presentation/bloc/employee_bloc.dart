import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:employee/feature/employee/domain/model/employee.dart';
import 'package:employee/feature/employee/domain/repository/employee_repo.dart';
import 'package:equatable/equatable.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc({required this.employeeRepo}) : super(EmployeeInitial()) {
    on<AddEmployee>(_addEmployee);
    on<UpdateEmployee>(_updateEmployee);
    on<DeleteEmployee>(_deleteEmployee);
    on<FetchEmployees>(_fetchEmployee);
  }

  final EmployeeRepo employeeRepo;

  FutureOr<void> _fetchEmployee(event, emit) async {
    try {
      emit(EmployeeLoading());
      final employees = employeeRepo.getAllEmployees();

      final List<Employee> currentEmployee = [];
      final List<Employee> previousEmployee = [];

      for (var employee in employees) {
        if (employee.toDate == null) {
          currentEmployee.add(employee);
        } else {
          previousEmployee.add(employee);
        }
      }
      emit(EmployeeLoaded(currentEmployee, previousEmployee));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }

  FutureOr<void> _deleteEmployee(event, emit) async {
    try {
      emit(EmployeeLoading());
      await employeeRepo.deleteEmployee(event.index);
      emit(const EmployeeSuccess('Employee Deleted'));

      add(FetchEmployees());
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }

  FutureOr<void> _updateEmployee(event, emit) async {
    try {
      emit(EmployeeLoading());
      await employeeRepo.updateEmployee(event.employee);
      emit(const EmployeeSuccess('Employee Updated'));

      add(FetchEmployees());
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }

  FutureOr<void> _addEmployee(event, emit) async {
    try {
      emit(EmployeeLoading());
      await employeeRepo.createEmployee(event.employee);
      emit(const EmployeeSuccess('Employee Added'));

      add(FetchEmployees());
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }
}
