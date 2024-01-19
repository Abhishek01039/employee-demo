import 'package:employee/feature/employee/data/data_source/crud_employee.dart';
import 'package:employee/feature/employee/domain/model/employee.dart';
import 'package:employee/feature/employee/domain/repository/employee_repo.dart';

class EmployeeRepoImpl extends EmployeeRepo {
  EmployeeRepoImpl({required EmployeeCRUD employeeCRUD})
      : _employeeCRUD = employeeCRUD;

  final EmployeeCRUD _employeeCRUD;

  @override
  Future<void> createEmployee(Employee employee) async {
    await _employeeCRUD.createEmployee(employee);
  }

  @override
  Future<void> deleteEmployee(int index) async {
    await _employeeCRUD.deleteEmployee(index);
  }

  @override
  List<Employee> getAllEmployees() {
    return _employeeCRUD.getAllEmployees();
  }

  @override
  Future<void> updateEmployee(Employee employee) async {
    await _employeeCRUD.updateEmployee(employee);
  }
}
