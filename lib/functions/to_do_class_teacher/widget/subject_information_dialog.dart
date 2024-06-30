import 'package:flutter/material.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/constants/string_constants.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/models/class_model.dart';

class SubjectInformationDialog extends StatelessWidget {
  final ClassRoomModel classRoomModel;
  const SubjectInformationDialog({super.key, required this.classRoomModel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 280,
        width: 280,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          // mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 280,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: Gradients.gradientRedtop,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Text(
                "Thông tin lớp học",
                style: AppTextStyles.text15W500White,
              ),
            ),
            Spacer(),
            Text(
              classRoomModel.dataSubject!.subjectName,
              style: AppTextStyles.text15W500Gray,
            ),
            Text(
              "Mã học phần: ${classRoomModel.dataSubject!.subjectId}",
              style: AppTextStyles.text15W500Gray,
            ),
            Text(
              "Phòng học: ${classRoomModel.className}",
              style: AppTextStyles.text15W500Gray,
            ),
            Spacer(),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 42,
                width: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: Gradients.gradientRed,
                    borderRadius: BorderRadius.circular(50)),
                child: const Text(
                  StringConst.done,
                  style: AppTextStyles.text16W500White,
                ),
              ),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
