import 'package:employee/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:employee/feature/employee/presentation/widgets/employee_app_bar.dart';
import 'package:employee/feature/employee/presentation/widgets/employee_item.dart';
import 'package:employee/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class EmployeeDetailScreen extends StatelessWidget {
  const EmployeeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 6);

    return Scaffold(
      extendBody: true,
      appBar: const EmployeeAppBar(
        title: 'Employee List',
      ),
      body: BlocConsumer<EmployeeBloc, EmployeeState>(
        listener: (context, state) {
          if (state is EmployeeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: ColorConstant.green,
              ),
            );
            if (!state.message.toLowerCase().contains('deleted')) {
              context.pop();
            }
          }
        },
        builder: (context, state) {
          if (state is EmployeeLoaded) {
            if (state.currentEmployee.isEmpty &&
                state.previousEmployee.isEmpty) {
              return Center(
                child: SvgPicture.asset('assets/images/no_employee.svg'),
              );
            }
            return ListView(
              children: [
                if (state.currentEmployee.isNotEmpty)
                  Container(
                    color: ColorConstant.grey,
                    height: 56,
                    width: MediaQuery.of(context).size.width,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          'Current employees',
                          style: TextStyle(color: Color(0xff1DA1F2)),
                        ),
                      ),
                    ),
                  ),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.currentEmployee.length > 4
                      ? 4
                      : state.currentEmployee.length,
                  itemBuilder: (BuildContext context, int index) {
                    final length = state.currentEmployee.length > 4
                        ? 4
                        : state.currentEmployee.length;
                    bool isLastItem = index == length - 1;
                    final emp = state.currentEmployee[index];

                    return EmployeeItem(
                      emp: emp,
                      gap: gap,
                      isLastItem: isLastItem,
                    );
                  },
                ),
                if (state.previousEmployee.isNotEmpty)
                  Container(
                    height: 56,
                    width: MediaQuery.of(context).size.width,
                    color: ColorConstant.grey,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          'Previous employees',
                          style: TextStyle(color: Color(0xff1DA1F2)),
                        ),
                      ),
                    ),
                  ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.previousEmployee.length,
                  itemBuilder: (BuildContext context, int index) {
                    bool isLastItem =
                        index == state.previousEmployee.length - 1;
                    final emp = state.previousEmployee[index];

                    return EmployeeItem(
                      emp: emp,
                      gap: gap,
                      isLastItem: isLastItem,
                    );
                  },
                ),
              ],
            );
          }
          if (state is EmployeeLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return Center(
            child: SvgPicture.asset('assets/images/no_employee.svg'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /// Navigate to add employee screen
          context.push('/add');
        },
        backgroundColor: const Color(0xff1DA1F2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Icon(
          Icons.add,
          color: ColorConstant.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      bottomNavigationBar: BottomAppBar(
        color: ColorConstant.grey,
        surfaceTintColor: ColorConstant.grey,
        child: const Text(
          'Swipe left to delete',
          style: TextStyle(
            color: Color(0xff949C9E),
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
