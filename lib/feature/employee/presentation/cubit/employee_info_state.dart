part of 'employee_info_cubit.dart';

class EmployeeInfoState extends Equatable {
  const EmployeeInfoState({
    required this.employee,
    this.tempFromDate,
    this.tempToDate,
  });

  final Employee employee;
  final DateTime? tempFromDate;
  final DateTime? tempToDate;

  EmployeeInfoState copyWith({
    Employee? employee,
    DateTime? tempFromDate,
    DateTime? tempToDate,
    bool isTempToDateClear = false,
  }) {
    return EmployeeInfoState(
      employee: employee ?? this.employee,
      tempFromDate: tempFromDate ?? this.tempFromDate,
      tempToDate: isTempToDateClear ? null : tempToDate ?? this.tempToDate,
    );
  }

  @override
  List<Object?> get props => [employee, tempFromDate, tempToDate];
}
