import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/constants/string_constants.dart';
import 'package:qldtandroid/core/enums/classSession.dart';
import 'package:qldtandroid/core/enums/day_of_week.dart';
import 'package:qldtandroid/core/models/selectable_Item.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/add_class_teacher/bloc/add_class_teacher_bloc.dart';
import 'package:qldtandroid/functions/add_class_teacher/screen/show_list_class_screen.dart';
import 'package:qldtandroid/main.dart';
import 'package:qldtandroid/models/class_model.dart';
import 'package:qldtandroid/models/subject_model.dart';
import 'package:qldtandroid/widgets/notification_dialog.dart';

class AddClassScreen extends StatefulWidget {
  final SubjectModel subjectModel;
  const AddClassScreen({super.key, required this.subjectModel});

  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  String? _selectedDay;
  int? _selectedIntDay;
  final TextEditingController _textClassRoomNameController =
      TextEditingController();
  final TextEditingController _textMaxStudentController =
      TextEditingController();
  final List<bool> _selectedShifts =
      List<bool>.filled(ClassSession.values.length, false);

  @override
  void initState() {
    super.initState();
    _selectedDay = null; // Initialize with a default value if necessary
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.red.withOpacity(0.7),
      body: BlocListener<AddClassTeacherBloc, AddClassTeacherState>(
        listener: (context, state) {
          if (state.status == AddClassStatus.classBusy) {
            showDialog(
              context: context,
              builder: (context) {
                return const NotificationSignUp(
                  message: 'Phòng học thời điểm hiện tại đã có lớp học',
                );
              },
            );
          } else if (state.status == AddClassStatus.teacherBusy) {
            showDialog(
              context: context,
              builder: (context) {
                return const NotificationSignUp(
                  message: 'Bạn đã có lớp vào thời điểm này rồi',
                );
              },
            );
          } else if (state.status == AddClassStatus.addSuccess) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowListClassTeacher(),
                )); 
            showDialog(
              context: context,
              builder: (context) {
                return const NotificationSignUp(
                  message: 'Tạo lớp thành công',
                );
              },
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 80,
                width: double.infinity,
                alignment: Alignment.center,
                // padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    gradient: Gradients.gradientRed),
                child: const Text(
                  StringConst.makeClass,
                  style: AppTextStyles.text18BoldWhite,
                ),
              ),
              _showSubjectName(),
              _showSubjectID(),
              _showTeacherName(),
              _showClassName(),
              _showDayOfWeek(),
              _showSession(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 40,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      color: AppColors.white
                      ),
                      child: Text("Hủy"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<AddClassTeacherBloc>(context).add(
                          AddClassEvent(
                              classRoomModel: ClassRoomModel(
                                  className: _textClassRoomNameController.text,
                                  classId: " ",
                                  mscb: authTeacher.mscb,
                                  subjectId: widget.subjectModel.subjectId,
                                  dayOfWeek: _selectedIntDay!.toString(),
                                  maxStudent:
                                      int.parse(_textMaxStudentController.text),
                                  classSession:
                                      convertSelectionsToString(_selectedShifts))));
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: Gradients.gradientRed,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Text(
                        StringConst.done,
                        style: AppTextStyles.text16BoldWhite,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _showSubjectName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 8.0),
      child: Row(
        children: [
          const Text(
            "Môn học :            ",
            style: AppTextStyles.text16NormalWhite,
          ),
          Text(
            widget.subjectModel.subjectName,
            style: AppTextStyles.text16BoldWhite,
          ),
        ],
      ),
    );
  }

  Widget _showSubjectID() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 8.0),
      child: Row(
        children: [
          Text(
            "Mã Học Phần:                ${widget.subjectModel.subjectId}",
            style: AppTextStyles.text16NormalWhite,
          ),
        ],
      ),
    );
  }

  Widget _showTeacherName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 8.0),
      child: Row(
        children: [
          const Text(
            "Giáo viên đứng lớp :                ",
            style: AppTextStyles.text16NormalWhite,
          ),
          Text(
            authTeacher.name,
            style: AppTextStyles.text18BoldWhite,
          ),
        ],
      ),
    );
  }

  Widget _showClassName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 40,
                alignment: Alignment.center,
                child: const Text(
                  "Phòng học :   ",
                  style: AppTextStyles.text16NormalWhite,
                ),
              ),
              SizedBox(
                width: 100,
                height: 62,
                child: TextFormField(
                  controller: _textClassRoomNameController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    // labelText: 'Enter an integer',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          // const SizedBox(width: 100,),
          Row(
            children: [
              Container(
                height: 40,
                alignment: Alignment.center,
                child: const Text(
                  "Số lượng sinh viên tối đa :  ",
                  style: AppTextStyles.text16NormalWhite,
                ),
              ),
              SizedBox(
                width: 62,
                height: 62,
                child: TextFormField(
                  style: AppTextStyles.text15W500White,
                  controller: _textMaxStudentController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    // labelText: 'Enter an integer',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _showDayOfWeek() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0),
      child: Row(
        children: [
          const Text(
            "Thứ trong tuần :              ",
            style: AppTextStyles.text16NormalWhite,
          ),
          DropdownButton<String>(
            style: AppTextStyles.text16BoldWhite,
            dropdownColor: AppColors.red,
            iconDisabledColor: AppColors.white,
            iconEnabledColor: AppColors.white,
            hint: const Text(
              'Chọn ngày',
              style: AppTextStyles.text16W500White,
            ),
            value: _selectedDay,
            items: DayOfWeek.selectableItemList.map((SelectableItem item) {
              return DropdownMenuItem<String>(
                value: item.id,
                child: Center(child: Text(item.name)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedDay = newValue;
                _selectedIntDay = newValue != null ? int.parse(newValue) : null;
              });
            },
            selectedItemBuilder: (BuildContext context) {
              return DayOfWeek.selectableItemList.map((SelectableItem item) {
                return Center(
                  child: Text(
                    item.name,
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList();
            },
            // isExpanded: true,
          )
        ],
      ),
    );
  }

  Widget _showSession() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            alignment: Alignment.center,
            child: const Text(
              "Ca làm việc :         ",
              style: AppTextStyles.text16NormalWhite,
            ),
          ),
          SizedBox(
            width: 400,
            height: 80,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ClassSession.selectableItemList.length,
                itemBuilder: (context, index) {
                  final item = ClassSession.selectableItemList[index];
                  return SizedBox(
                    width: 60,
                    height: 60,
                    child: CustomCheckboxListTile(
                      title: item.name,
                      value: _selectedShifts[index],
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedShifts[index] = value!;
                        });
                      },
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class CustomCheckboxListTile extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool?) onChanged;

  const CustomCheckboxListTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: SizedBox(
        height: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,

              materialTapTargetSize: MaterialTapTargetSize
                  .shrinkWrap, // Loại bỏ đệm không cần thiết
              visualDensity: VisualDensity.standard,
            ),
            Text(
              title,
              style: AppTextStyles.text15W500White,
            ),
          ],
        ),
      ),
    );
  }
}

String convertSelectionsToString(List<bool> selections) {
  String result = '';

  for (int i = 0; i < selections.length; i++) {
    if (selections[i]) {
      if (result.isNotEmpty) {
        result += ',';
      }
      result += (i + 1).toString();
    }
  }

  return result;
}
