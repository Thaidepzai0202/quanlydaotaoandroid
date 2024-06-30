import 'package:flutter/material.dart';
import 'package:qldtandroid/core/constants/image.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/core/themes/app_text_style.dart';
import 'package:qldtandroid/functions/add_class_teacher/screen/select_subject_screen.dart';
import 'package:qldtandroid/functions/log_in/screen/login_view.dart';
import 'package:qldtandroid/functions/to_do_class_teacher/screen/schedule_teacher_screen.dart';

class MainLayoutDrawer extends StatefulWidget {
  const MainLayoutDrawer({super.key});

  @override
  State<MainLayoutDrawer> createState() => _MainLayoutDrawerState();
}

class _MainLayoutDrawerState extends State<MainLayoutDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      child: Container(
        color: AppColors.primaryHust.withOpacity(0.8),
        child: Column(
          children: [
            _logoHust(),
            _addClass(),
            SizedBox(height: 10,),
            _schedule(),
            Spacer(),
            _logOut(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _logoHust() {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Image.asset(Images.logo_hust),
    );
  }

  Widget _addClass() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder:(context) => SelectSubjectScreen(),));
      } ,
      child: Container(
          height: 42,
          width: 120,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: AppColors.white),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.add,
                color: AppColors.white,
                size: 20,
              ),
              Text(
                "Thêm lớp",
                style: AppTextStyles.text16W500White,
              ),
            ],
          )),
    );
  }

  Widget _schedule() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder:(context) => ScheduleTeacherScreen(),));
      } ,
      child: Container(
          height: 42,
          width: 140,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: AppColors.white),
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            "Thời khóa biểu",
            style: AppTextStyles.text16W500White,
          )),
    );
  }

  Widget _logOut() {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          )),
      child: Container(
          height: 42,
          width: 120,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: AppColors.white),
              borderRadius: BorderRadius.circular(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.logout,
                color: AppColors.white,
                size: 20,
              ),
              Text(
                "Đăng xuất",
                style: AppTextStyles.text16W500White,
              ),
            ],
          )),
    );
  }
}
