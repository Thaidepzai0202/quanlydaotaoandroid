import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/models/leave_request_model.dart';

class LeaveReaquestItem extends StatelessWidget {
  final LeaveRequestModel leaveRequestModel;
  const LeaveReaquestItem({super.key, required this.leaveRequestModel});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd/MM/yyyy HH:mm:ss').format(leaveRequestModel.createdAt!);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(leaveRequestModel.studentName ?? ""),
                Text(leaveRequestModel.mssv ?? ""),
              ],
            ),
            Text(leaveRequestModel.reason ?? "",style: AppTextStyles.text16NormalGray,),
            Row(
              children: [
                Spacer(),
                Text(formattedDate,style: AppTextStyles.text12W500Gray,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
