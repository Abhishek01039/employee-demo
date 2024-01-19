import 'package:flutter/material.dart';

class EmployeeTextField extends StatelessWidget {
  const EmployeeTextField({
    super.key,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.onChanged,
    this.initialValue,
    this.onTapOutside,
    this.readOnly = false,
  });

  final void Function()? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final void Function(String)? onChanged;
  final String? initialValue;
  final void Function(PointerDownEvent)? onTapOutside;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: const BorderSide(
        color: Color(0xFFE5E5E5),
      ),
    );

    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        prefixIconColor: const Color(0xff1DA1F2),
        suffixIconColor: const Color(0xff1DA1F2),
        enabledBorder: border,
        focusedBorder: border,
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xff949C9E)),
        contentPadding: const EdgeInsets.all(15.0),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      onTap: onTap,
      readOnly: readOnly,
      onChanged: onChanged,
      onTapOutside: onTapOutside,
    );
  }
}
