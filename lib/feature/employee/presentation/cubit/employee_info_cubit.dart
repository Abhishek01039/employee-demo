import 'package:bloc/bloc.dart';
import 'package:employee/feature/employee/domain/model/employee.dart';
import 'package:equatable/equatable.dart';

part 'employee_info_state.dart';

class EmployeeInfoCubit extends Cubit<EmployeeInfoState> {
  EmployeeInfoCubit({Employee? employee})
      : super(EmployeeInfoState(employee: employee ?? const Employee()));

  void updateEmployeeName(String name) {
    final emp = state.employee.copyWith(name: name);
    emit(state.copyWith(employee: emp));
  }

  void updateRole(String role) {
    final emp = state.employee.copyWith(role: role);
    emit(state.copyWith(employee: emp));
  }

  void updateFromDate(DateTime fromDate) {
    final emp = state.employee.copyWith(fromDate: fromDate);
    emit(state.copyWith(employee: emp));
  }

  void updateTempFromDate(DateTime fromDate) {
    emit(state.copyWith(tempFromDate: fromDate));
  }

  void updateToDate(DateTime toDate) {
    final emp = state.employee.copyWith(toDate: toDate);
    emit(state.copyWith(employee: emp));
  }

  void updateTempToDate(DateTime toDate) {
    emit(state.copyWith(tempToDate: toDate));
  }

  /// clear tempFromDate and tempToDate
  void clearTempDate() {
    final emp = state.employee.copyWith(isToDateClear: true);
    emit(state.copyWith(isTempToDateClear: true, employee: emp));
  }
}
