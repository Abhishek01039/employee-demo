import 'package:employee/feature/employee/data/data_source/crud_employee.dart';
import 'package:employee/feature/employee/data/repository/employee_repo_impl.dart';
import 'package:employee/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:employee/router.dart';
import 'package:employee/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeApp extends StatelessWidget {
  const EmployeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeBloc(
        employeeRepo: EmployeeRepoImpl(
          employeeCRUD: EmployeeCRUD(),
        ),
      )..add(FetchEmployees()),
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Employee App',
        theme: ThemeData(
          primarySwatch: ColorConstant.blue,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
