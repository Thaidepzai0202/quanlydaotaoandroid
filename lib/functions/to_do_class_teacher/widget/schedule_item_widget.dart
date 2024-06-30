import 'package:flutter/material.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/core/themes/app_text_style.dart';
import 'package:qldtandroid/functions/to_do_class_teacher/widget/subject_information_dialog.dart';
import 'package:qldtandroid/models/class_model.dart';

class ScheduleItemWidget extends StatelessWidget {
  final int index;
  final ClassRoomModel? classRoomModel;
  const ScheduleItemWidget(
      {super.key, this.classRoomModel, required this.index});

  @override
  Widget build(BuildContext context) {
    if (classRoomModel == null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 32,
          width: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.gray.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(3, 3), // changes position of shadow
                ),
                BoxShadow(
                  color: AppColors.gray.withOpacity(0.1),
                  spreadRadius: 0.2,
                  blurRadius: 2,
                  offset: Offset(-1, -1), // changes position of shadow
                ),
              ]),
          child: Text(
            "$index",
            style: AppTextStyles.text12W500Gray,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            showDialog(context: context, builder:(context) => SubjectInformationDialog(classRoomModel: classRoomModel!),);
          },
          child: Container(
            height: 32,
            width: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: Gradients.gradientRed,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gray.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                  BoxShadow(
                    color: AppColors.gray.withOpacity(0.1),
                    spreadRadius: 0.2,
                    blurRadius: 2,
                    offset: Offset(-1, -1), // changes position of shadow
                  ),
                ]),
            child: Text(
              "$index",
              style: AppTextStyles.text12W500White,
            ),
          ),
        ),
      );
    }
  }
}
