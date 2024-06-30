import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qldtandroid/core/constants/image.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/core/themes/input_decorations.dart';

class PasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool showIconLock;
  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  const PasswordField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.showIconLock = true,
    this.autovalidateMode,
    this.onChanged,
    this.focusNode,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      // style: const TextStyle(
      //   fontSize: 16,
      //   color: AppColors.tundora,
      // ),
      obscureText: isVisible,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      decoration: InputDecorationConst().emailForm.copyWith(
            fillColor: AppColors.white,
            hintText: widget.hintText,
            prefixIcon: Container(
              padding: const EdgeInsets.only(left: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  Images.ic_pass,
                  // ignore: deprecated_member_use
                  color: AppColors.grey666,
                ),
              ),
            ),
            suffixIcon: IconButton(
              onPressed: () => setState(() => isVisible = !isVisible),
              // padding: EdgeInsets.only(right: 16),
              // constraints: BoxConstraints(maxHeight: 20),
              splashRadius: 8,
              // iconSize: 5,
              icon: Container(
                padding: const EdgeInsets.only(right: 10),
                child: SvgPicture.asset(
                  isVisible ? Images.eye_off_2 : Images.ic_eye,
                  // ignore: deprecated_member_use
                  color: isVisible ? AppColors.gray : AppColors.primaryHust,
                ),
              ),
            ),
            // hintStyle: TextStyle(color: AppColors.gray),
          ),
    );
  }
}
