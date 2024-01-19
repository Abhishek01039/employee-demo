part of 'employee_bloc.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object?> get props => [];
}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeSuccess extends EmployeeState {
  final String message;

  const EmployeeSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class EmployeeLoaded extends EmployeeState {
  final List<Employee> currentEmployee;
  final List<Employee> previousEmployee;

  const EmployeeLoaded(this.currentEmployee, this.previousEmployee);

  @override
  List<Object?> get props => [currentEmployee, previousEmployee];
}

class EmployeeError extends EmployeeState {
  final String message;

  const EmployeeError(this.message);

  @override
  List<Object?> get props => [message];
}
