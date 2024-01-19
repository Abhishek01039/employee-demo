/// Create go_router for employee details
import 'package:employee/feature/employee/domain/model/employee.dart';
import 'package:employee/feature/employee/presentation/add_employee_screen.dart';
import 'package:employee/feature/employee/presentation/employee_detail_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const EmployeeDetailScreen(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) =>
          AddEmployeeScreen(employee: state.extra as Employee?),
    ),
  ],
);
