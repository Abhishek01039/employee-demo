import 'package:employee/feature/employee/domain/model/employee.dart';
import 'package:employee/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:employee/feature/employee/presentation/cubit/employee_info_cubit.dart';
import 'package:employee/feature/employee/presentation/widgets/employee_app_bar.dart';
import 'package:employee/feature/employee/presentation/widgets/employee_date_picker.dart';
import 'package:employee/feature/employee/presentation/widgets/employee_text_field.dart';
import 'package:employee/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AddEmployeeScreen extends StatelessWidget {
  AddEmployeeScreen({super.key, this.employee});

  final Employee? employee;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final roles = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner',
  ];

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 23);

    return BlocProvider(
      create: (_) => EmployeeInfoCubit(employee: employee),
      child: BlocBuilder<EmployeeInfoCubit, EmployeeInfoState>(
        builder: (context, state) {
          return Scaffold(
            appBar: EmployeeAppBar(
              title: employee != null
                  ? 'Edit Employee Details'
                  : 'Add Employee Details',
              deleteIcon: employee != null
                  ? IconButton(
                      onPressed: () {
                        context
                            .read<EmployeeBloc>()
                            .add(DeleteEmployee(state.employee.id!));
                        context.pop();
                      },
                      icon:
                          const Icon(Icons.delete, color: ColorConstant.white),
                    )
                  : null,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    EmployeeTextField(
                      initialValue: state.employee.name,
                      onTapOutside: (PointerDownEvent event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      hintText: 'Employee name',
                      prefixIcon: const Icon(
                        Icons.person_outline,
                      ),
                      onChanged: (value) => context
                          .read<EmployeeInfoCubit>()
                          .updateEmployeeName(value),
                    ),
                    gap,
                    EmployeeTextField(
                      key: UniqueKey(),
                      initialValue: state.employee.role,
                      hintText: 'Select role',
                      readOnly: true,
                      prefixIcon: const Icon(Icons.work_outline),
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 50,
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => BlocProvider.value(
                            value: context.read<EmployeeInfoCubit>(),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: ColorConstant.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  topRight: Radius.circular(16.0),
                                ),
                              ),
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: roles.length,
                                itemBuilder: (context, index) => ListTile(
                                  title: Center(child: Text(roles[index])),
                                  onTap: () {
                                    context
                                        .read<EmployeeInfoCubit>()
                                        .updateRole(roles[index]);
                                    context.pop();
                                  },
                                ),
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    gap,
                    Row(
                      children: [
                        Expanded(
                          child: EmployeeTextField(
                            key: UniqueKey(),
                            initialValue: state.employee.fromDate != null
                                ? DateFormat('d MMM yyyy')
                                    .format(state.employee.fromDate!)
                                : null,
                            hintText: 'No date',
                            readOnly: true,
                            prefixIcon: const Icon(Icons.event),
                            onTap: () => selectDate(
                                context: context,
                                isFrom: true,
                                cubit: context.read<EmployeeInfoCubit>()),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Color(0xff1DA1F2),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: EmployeeTextField(
                            key: UniqueKey(),
                            initialValue: state.employee.toDate != null
                                ? DateFormat('d MMM yyyy')
                                    .format(state.employee.toDate!)
                                : null,
                            hintText: 'No date',
                            readOnly: true,
                            prefixIcon: const Icon(Icons.event),
                            onTap: () => selectDate(
                                context: context,
                                cubit: context.read<EmployeeInfoCubit>()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(
                    color: Color(0xffF2F2F2),
                    thickness: 2,
                  ),
                  BottomAppBar(
                    height: 50,
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            backgroundColor: const Color(0xffEDF8FF),
                          ),
                          onPressed: () => context.pop(),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Color(0xFF1DA1F2),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            backgroundColor: const Color(0xff1DA1F2),
                          ),
                          onPressed: () {
                            if (employee == null) {
                              context
                                  .read<EmployeeBloc>()
                                  .add(AddEmployee(state.employee));
                            } else {
                              context
                                  .read<EmployeeBloc>()
                                  .add(UpdateEmployee(state.employee));
                            }
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(color: ColorConstant.white),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
