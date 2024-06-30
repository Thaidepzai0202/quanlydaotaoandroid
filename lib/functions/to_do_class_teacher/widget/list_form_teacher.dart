import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/to_do_class_student/widget/test_item_widget.dart';
import 'package:qldtandroid/functions/to_do_class_teacher/bloc/form_teacher_bloc.dart';

class ListFormTeacherWidget extends StatefulWidget {
  final String classID;
  const ListFormTeacherWidget({super.key, required this.classID});

  @override
  State<ListFormTeacherWidget> createState() => _ListFormTeacherWidgetState();
}

class _ListFormTeacherWidgetState extends State<ListFormTeacherWidget> {
  @override
  void initState() {
    BlocProvider.of<FormTeacherBloc>(context)
        .add(ShowListFormEvent(classID: widget.classID));
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormTeacherBloc, FormTeacherState>(
      builder: (context, state) {
        if (state.status == FormTeacherStatus.initial) {
          return Center(child: const CircularProgressIndicator(),);
        } else {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white),
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: state.listTest!.length,
                  itemBuilder: (context, index) {
                    return TestItemWidget(
                      testModel: state.listTest![index],
                    );
                  },
                ))
              ],
            ),
          );
        }
      },
    );
  }
}
