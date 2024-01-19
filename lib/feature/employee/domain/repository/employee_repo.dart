import 'package:employee/feature/employee/domain/model/employee.dart';

abstract class EmployeeRepo {
  // create employee
  Future<void> createEmployee(Employee employee);

  // update employee
  Future<void> updateEmployee(Employee employee);

  // delete employee
  Future<void> deleteEmployee(int index);

  // get all employees
  List<Employee> getAllEmployees();
}
