import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/leave_request/bloc/leave_request_bloc.dart';
import 'package:qldtandroid/functions/leave_request/widget/add_leave_request_dialog.dart';
import 'package:qldtandroid/functions/leave_request/widget/list_leave_request_item.dart';
import 'package:qldtandroid/functions/make_test_student/bloc/form_student_bloc.dart';

class ListLeaveRequestScreen extends StatefulWidget {
  const ListLeaveRequestScreen({super.key});

  @override
  State<ListLeaveRequestScreen> createState() => _ListLeaveRequestScreenState();
}

class _ListLeaveRequestScreenState extends State<ListLeaveRequestScreen> {
  @override
  void initState() {
    BlocProvider.of<LeaveRequestBloc>(context).add(InitGetListEvent(
        classID: BlocProvider.of<FormStudentBloc>(context).classID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                  height: 80,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: Gradients.gradientRedtop,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gray.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(3, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: const Text(
                    "Danh sách đơn xin phép",
                    style: AppTextStyles.text16BoldWhite,
                  )),
              Expanded(child: _listLeaveRequest())
            ],
          ),
          Positioned(
              top: 30,
              left: 20,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.close,
                  color: AppColors.white,
                ),
              )),
          _createLRButton()
        ],
      ),
    );
  }

  Widget _listLeaveRequest() {
    return BlocBuilder<LeaveRequestBloc, LeaveRequestState>(
      builder: (context, state) {
        if (state.status == LeaveRequestStatus.initial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: state.listLeaveRequest?.length,
            itemBuilder: (context, index) {
              return LeaveReaquestItem(
                  leaveRequestModel: state.listLeaveRequest![index]);
            },
          );
        }
      },
    );
  }

  Widget _createLRButton() {
    return Positioned(
      right: 20,
      bottom: 20,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AddLeaveRequestDialog(),
          );
        },
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: AppColors.red),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Icon(
                Icons.add,
                color: AppColors.red,
              ),
              Text(
                "Tạo mới",
                style: TextStyle(color: AppColors.red, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
