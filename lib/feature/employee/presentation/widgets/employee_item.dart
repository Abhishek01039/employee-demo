import 'package:employee/feature/employee/domain/model/employee.dart';
import 'package:employee/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:employee/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EmployeeItem extends StatelessWidget {
  const EmployeeItem({
    super.key,
    required this.emp,
    required this.gap,
    required this.isLastItem,
  });

  final Employee emp;
  final SizedBox gap;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    String dateFormat(DateTime date) {
      return DateFormat('d MMM, yyyy').format(date);
    }

    return Slidable(
      key: const ValueKey(0),
      closeOnScroll: true,
      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            onPressed: (context) {
              context.read<EmployeeBloc>().add(DeleteEmployee(emp.id!));
            },
            backgroundColor: ColorConstant.red,
            foregroundColor: ColorConstant.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: InkWell(
        onTap: () => context.push('/add', extra: emp),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      emp.name ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    gap,
                    Text(emp.role ?? ''),
                    gap,
                    if (emp.fromDate != null && emp.toDate != null)
                      Text(
                          '${dateFormat(emp.fromDate!)} - ${dateFormat(emp.toDate!)}')
                    else if (emp.fromDate != null)
                      Text('From ${dateFormat(emp.fromDate!)}'),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              if (!isLastItem) const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
