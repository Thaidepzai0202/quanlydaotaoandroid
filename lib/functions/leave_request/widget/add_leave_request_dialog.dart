import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/leave_request/bloc/leave_request_bloc.dart';

class AddLeaveRequestDialog extends StatefulWidget {
  const AddLeaveRequestDialog({super.key});

  @override
  State<AddLeaveRequestDialog> createState() => _AddLeaveRequestDialogState();
}

class _AddLeaveRequestDialogState extends State<AddLeaveRequestDialog> {
  TextEditingController _reasonCotroller = TextEditingController();

  @override
  void dispose() {
    _reasonCotroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocListener<LeaveRequestBloc, LeaveRequestState>(
        listener: (context, state) {
          if (state.status == LeaveRequestStatus.addSuccess) {
            Navigator.pop(context);
            BlocProvider.of<LeaveRequestBloc>(context).add(InitGetListEvent(
                classID: BlocProvider.of<LeaveRequestBloc>(context).classID));
          }
        },
        child: Container(
          height: 280,
          width: 280,
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Container(
                height: 40,
                width: 280,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: Gradients.gradientRedtop,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Text(
                  "Lý do nghỉ học",
                  style: AppTextStyles.text16BoldWhite,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                    controller: _reasonCotroller,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 32),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: AppColors.gray)),
                        border: InputBorder.none,
                        hintText: "Lý do nghỉ học",
                        hintStyle: AppTextStyles.text15W500Gray)),
              ),
              Spacer(),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<LeaveRequestBloc>(context).add(
                        SendLeaveRequestEvent(reason: _reasonCotroller.text));
                  },
                  child: Text("Tạo"))
            ],
          ),
        ),
      ),
    );
  }
}
