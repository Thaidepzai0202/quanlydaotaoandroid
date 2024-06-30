import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qldtandroid/core/constants/image.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';

class InputDecorationConst {
  InputDecoration emailForm = InputDecoration(
    fillColor: AppColors.white,
    hoverColor: AppColors.white,
    focusColor: AppColors.white,
    filled: true,
    border: InputBorder.none,
    contentPadding: const EdgeInsets.all(10),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: AppColors.gray, width: 1)),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: AppColors.gray, width: 1)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: AppColors.red, width: 1)),
    hintStyle: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.gray),
    prefixIcon: Container(
      padding: const EdgeInsets.only(left: 10),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SvgPicture.asset(
          Images.ic_person,
          height: 10,
          width: 10,
          // ignore: deprecated_member_use
          color: AppColors.grey666,
        ),
      ),
    ),
  );
}
