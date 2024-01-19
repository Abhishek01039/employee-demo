import 'package:employee/utils/color_constant.dart';
import 'package:flutter/material.dart';

class EmployeeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmployeeAppBar({
    super.key,
    required this.title,
    this.deleteIcon,
  });

  final String title;
  final Widget? deleteIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff1DA1F2),
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: const TextStyle(color: ColorConstant.white),
      ),
      actions: deleteIcon == null
          ? null
          : [
              deleteIcon!,
            ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
