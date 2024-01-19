import 'package:employee/feature/employee/presentation/cubit/employee_info_cubit.dart';
import 'package:employee/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

Future<void> selectDate({
  required BuildContext context,
  bool isFrom = false,
  required EmployeeInfoCubit cubit,
}) async {
  await showDialog(
    context: context,
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: BlocBuilder<EmployeeInfoCubit, EmployeeInfoState>(
        builder: (context, state) {
          return Dialog(
            surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isFrom)
                  IsFromFunctionality(isFrom: isFrom)
                else
                  IsToFunctionality(isFrom: isFrom),
                TableCalendar(
                  headerStyle: const HeaderStyle(
                    headerPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  focusedDay: (isFrom
                      ? (state.tempFromDate ?? DateTime.now())
                      : (state.tempToDate ?? DateTime.now())),
                  currentDay: isFrom ? state.tempFromDate : state.tempToDate,
                  firstDay: DateTime(2020),
                  calendarFormat: CalendarFormat.month,
                  lastDay: DateTime(2050),
                  onDaySelected: (dateTime, _) {
                    if (context.mounted) {
                      onTempDateSelect(
                          context: context, date: dateTime, isFrom: isFrom);
                    }
                  },
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: Color(0xffF2F2F2),
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.event,
                        color: Color(0xff1DA1F2),
                      ),
                      if (isFrom)
                        Text(state.tempFromDate != null
                            ? DateFormat('d MMM yyyy')
                                .format(state.tempFromDate!)
                            : 'No date')
                      else
                        Text(state.tempToDate != null
                            ? DateFormat('d MMM yyyy').format(state.tempToDate!)
                            : 'No date'),
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
                          onDateSelect(
                              context: context,
                              date: (isFrom
                                      ? state.tempFromDate
                                      : state.tempToDate) ??
                                  DateTime.now(),
                              isFrom: isFrom);
                          context.pop();
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(color: ColorConstant.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    ),
  );
}

class IsFromFunctionality extends StatelessWidget {
  const IsFromFunctionality({
    super.key,
    this.isFrom = false,
  });

  final bool isFrom;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeInfoCubit, EmployeeInfoState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        backgroundColor: const Color(0xffEDF8FF),
                      ),
                      onPressed: () => onTempDateSelect(
                        context: context,
                        date: DateTime.now(),
                        isFrom: isFrom,
                      ),
                      child: const Text(
                        'Today',
                        style: TextStyle(
                          color: Color(0xFF1DA1F2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        backgroundColor: const Color(0xffEDF8FF),
                      ),
                      onPressed: () => onTempDateSelect(
                        context: context,
                        date: findNextMonday(
                            (isFrom ? state.tempFromDate : state.tempToDate) ??
                                DateTime.now()),
                        isFrom: isFrom,
                      ),
                      child: const Text(
                        'Next Monday',
                        style: TextStyle(
                          color: Color(0xFF1DA1F2),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        backgroundColor: const Color(0xffEDF8FF),
                      ),
                      onPressed: () => onTempDateSelect(
                        context: context,
                        date: findNextTuesday(
                            (isFrom ? state.tempFromDate : state.tempToDate) ??
                                DateTime.now()),
                        isFrom: isFrom,
                      ),
                      child: const Text(
                        'Next Tuesday',
                        style: TextStyle(
                          color: Color(0xFF1DA1F2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        backgroundColor: const Color(0xffEDF8FF),
                      ),
                      onPressed: () => onTempDateSelect(
                        context: context,
                        date: (state.tempFromDate ?? DateTime.now())
                            .add(const Duration(days: 7)),
                        isFrom: isFrom,
                      ),
                      child: const Text(
                        'After 1 week',
                        style: TextStyle(
                          color: Color(0xFF1DA1F2),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class IsToFunctionality extends StatelessWidget {
  const IsToFunctionality({
    super.key,
    this.isFrom = false,
  });

  final bool isFrom;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeInfoCubit, EmployeeInfoState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    backgroundColor: const Color(0xffEDF8FF),
                  ),
                  onPressed: () {
                    context.read<EmployeeInfoCubit>().clearTempDate();
                    context.pop();
                  },
                  child: const Text(
                    'No date',
                    style: TextStyle(
                      color: Color(0xFF1DA1F2),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    backgroundColor: const Color(0xffEDF8FF),
                  ),
                  onPressed: () => onTempDateSelect(
                    context: context,
                    date: DateTime.now(),
                    isFrom: isFrom,
                  ),
                  child: const Text(
                    'Today',
                    style: TextStyle(
                      color: Color(0xFF1DA1F2),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

onDateSelect({
  required BuildContext context,
  bool isFrom = false,
  required DateTime date,
}) {
  if (isFrom) {
    context.read<EmployeeInfoCubit>().updateFromDate(date);
  } else {
    context.read<EmployeeInfoCubit>().updateToDate(date);
  }
}

onTempDateSelect({
  required BuildContext context,
  bool isFrom = false,
  required DateTime date,
}) {
  if (isFrom) {
    context.read<EmployeeInfoCubit>().updateTempFromDate(date);
  } else {
    context.read<EmployeeInfoCubit>().updateTempToDate(date);
  }
}

DateTime findNextMonday(DateTime date) {
  int daysUntilNextMonday = DateTime.monday - date.weekday;
  if (daysUntilNextMonday <= 0) {
    // If today is Monday or later, find the next Monday
    daysUntilNextMonday += 7;
  }

  return date.add(Duration(days: daysUntilNextMonday));
}

DateTime findNextTuesday(DateTime date) {
  int daysUntilNextTuesday = DateTime.tuesday - date.weekday;
  if (daysUntilNextTuesday <= 0) {
    // If today is Tuesday or later, find the next Tuesday
    daysUntilNextTuesday += 7;
  }

  return date.add(Duration(days: daysUntilNextTuesday));
}
