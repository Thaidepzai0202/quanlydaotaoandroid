import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/enums/gender.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/add_class_teacher/bloc/add_class_teacher_bloc.dart';
import 'package:qldtandroid/functions/add_student_to_class/bloc/add_student_to_class_bloc.dart';
import 'package:qldtandroid/functions/attenndance_teacher/bloc/attendance_teacher_bloc.dart';
import 'package:qldtandroid/functions/leave_request/bloc/leave_request_bloc.dart';
import 'package:qldtandroid/functions/log_in/bloc/log_in_bloc.dart';
import 'package:qldtandroid/functions/log_in/screen/login_view.dart';
import 'package:qldtandroid/functions/main_layout_student/bloc/add_class_student_bloc.dart';
import 'package:qldtandroid/functions/make_test_student/bloc/form_student_bloc.dart';
import 'package:qldtandroid/functions/sign_up/bloc/sign_up_bloc.dart';
import 'package:qldtandroid/functions/to_do_class_student/bloc/study_document_bloc.dart';
import 'package:qldtandroid/functions/to_do_class_teacher/bloc/form_teacher_bloc.dart';
import 'package:qldtandroid/functions/update_point_teacher/bloc/class_room_teacher_bloc.dart';
import 'package:qldtandroid/models/student_model.dart';
import 'package:qldtandroid/models/teacher_model.dart';

// ObjectPerson localObjectPerson = ObjectPerson.student;
ObjectPerson localObjectPerson = ObjectPerson.teacher;
late StudentModel authStudent;
late TeacherModel authTeacher;
// MainLayoutSlect mainLayoutSlect = MainLayoutSlect.showClass;
// ValueNotifier<MainLayoutSelectTeacher> mainLayoutSelectTeacher = ValueNotifier<MainLayoutSelectTeacher>(MainLayoutSelectTeacher.showClass);
// ValueNotifier<MainLayoutSelectStudent> mainLayoutSelectStudent = ValueNotifier<MainLayoutSelectStudent>(MainLayoutSelectStudent.showClass);


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(
          create: (context) => LogInBloc(),
        ),
        BlocProvider(
          create: (context) => AddClassTeacherBloc(),
        ),
        BlocProvider(
          create: (context) => AddClassStudentBloc(),
        ),
        BlocProvider(
          create: (context) => ClassRoomTeacherBloc(),
        ),
        BlocProvider(
          create: (context) => FormTeacherBloc(),
        ),
        BlocProvider(
          create: (context) => FormStudentBloc(),
        ),
        BlocProvider(
          create: (context) => AttendanceTeacherBloc(),
        ),
        BlocProvider(
          create: (context) => StudyDocumentBloc(),
        ),
        BlocProvider(
          create: (context) => AddStudentToClassBloc(),
        ),
        BlocProvider(
          create: (context) => LeaveRequestBloc(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Quan ly dao tao ',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.red),
            useMaterial3: true,
          ),
          // home: const SignUpScreen()
          home: const LoginScreen()
          // home: AppMainLayout(),
          ),
    );
  }
}
