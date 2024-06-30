import 'package:flutter/material.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/constants/string_constants.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';

class NotificationSignUp extends StatelessWidget {
  final String message;
  const NotificationSignUp({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      child: SizedBox(
        height: 200,
        width: 300,
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: Gradients.gradientRed,
                  borderRadius:const  BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28))),
              child: const Text(
                StringConst.notification,
                style: AppTextStyles.text16BoldWhite,
              ),
            ),
            Container(
              height: 100,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(message),
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 42,
                width: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: Gradients.gradientRed,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: const  Text(StringConst.done,style: AppTextStyles.text16W500White,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
