import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/make_test_student/bloc/form_student_bloc.dart';
import 'package:qldtandroid/functions/to_do_class_student/widget/test_item_widget.dart';

class ListFormStudentWidget extends StatefulWidget {
  final String classID;
  const ListFormStudentWidget({super.key, required this.classID});

  @override
  State<ListFormStudentWidget> createState() => _ListFormStudentWidgetState();
}

class _ListFormStudentWidgetState extends State<ListFormStudentWidget> {
  @override
  void initState() {
    BlocProvider.of<FormStudentBloc>(context)
        .add(InitFormStudentEvent(classID: widget.classID));
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormStudentBloc, FormStudentState>(
      builder: (context, state) {
        if (state.status == FormStudentStatus.initial) {
          return Center(child: const CircularProgressIndicator());
        } else if (state.status == FormStudentStatus.failure) {
          return const Center(child: Text("ERRO"),);
        } else {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.listTest!.length,
              itemBuilder: (context, index) {
            return TestItemWidget(
              testModel: state.listTest![index],
            );
              },
            ),
          );
        }
      },
    );
  }
}
