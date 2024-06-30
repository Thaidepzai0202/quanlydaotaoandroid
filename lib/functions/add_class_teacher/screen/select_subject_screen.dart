import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/constants/string_constants.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/add_class_teacher/bloc/add_class_teacher_bloc.dart';
import 'package:qldtandroid/functions/add_class_teacher/screen/add_class_sceen.dart';
import 'package:qldtandroid/functions/add_class_teacher/screen/show_list_class_screen.dart';
import 'package:qldtandroid/models/subject_model.dart';

class SelectSubjectScreen extends StatefulWidget {
  // final List<SubjectModel> listSubject;
  const SelectSubjectScreen({super.key});

  @override
  State<SelectSubjectScreen> createState() => _SelectSubjectScreenState();
}

class _SelectSubjectScreenState extends State<SelectSubjectScreen> {
  List<SubjectModel> filteredItems = [];
  List<SubjectModel> listSubject = [];

  @override
  void initState() {
    BlocProvider.of<AddClassTeacherBloc>(context).add(ShowSubjectEvent());
    // print(listSubject.first.subjectName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // filteredItems =BlocProvider.of<AddClassTeacherBloc>(context).listSubject;
    return Scaffold(
      body: BlocBuilder<AddClassTeacherBloc, AddClassTeacherState>(
        builder: (context, state) {
          if (state.status == AddClassStatus.success) {
            listSubject = state.listSubject ?? [];
            // filteredItems = listSubject;

            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.white,
                  ),
                  // padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          height: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              gradient: Gradients.gradientRedtop,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.gray.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(
                                      3, 3), // changes position of shadow
                                ),
                              ]),
                          child: Text(
                            StringConst.listSubject,
                            style: AppTextStyles.text16BoldWhite,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      searchWidget(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(children: [
                                InkWell(
                                  onTap: () {
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (context) {
                                    //       return AddClassDialog(
                                    //         subjectModel: listSubject[index],
                                    //       );
                                    //     });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddClassScreen(
                                              subjectModel: listSubject[index]),
                                        ));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "${index + 1} . ${filteredItems[index].subjectName}"),
                                      Text(filteredItems[index].subjectId),
                                    ],
                                  ),
                                )
                              ]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 20,
                  child: InkWell(
                  onTap: () => Navigator.push(context,MaterialPageRoute(builder:(context) => ShowListClassTeacher(),),),
                  child: Icon(Icons.close,color: AppColors.white,)))
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void nameClassSearchResults(String query) {
    List<SubjectModel> dummyList = [];
    dummyList.addAll(listSubject);
    if (query.isNotEmpty) {
      List<SubjectModel> dummyListData = [];
      for (var item in dummyList) {
        if (item.subjectName.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        filteredItems = dummyListData;
      });
      return;
    } else {
      setState(() {
        filteredItems = listSubject;
      });
    }
  }

  void idClassSearchResults(String query) {
    List<SubjectModel> dummyList = [];
    dummyList.addAll(listSubject);
    if (query.isNotEmpty) {
      List<SubjectModel> dummyListData = [];
      for (var item in dummyList) {
        if (item.subjectId.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        filteredItems = dummyListData;
      });
      return;
    } else {
      setState(() {
        filteredItems = listSubject;
      });
    }
  }

  Widget searchWidget() {
    return Container(
      // width: 300,
      height: 60,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: TextField(
              onChanged: (value) {
                nameClassSearchResults(value);
              },
              // style: TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                hintText: "Tên môn học",
                hintStyle: TextStyle(color: AppColors.gray),
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.search, color: AppColors.gray),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: AppColors.gray),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: AppColors.gray),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: AppColors.gray),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextField(
              onChanged: (value) {
                idClassSearchResults(value);
              },
              // style: TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                hintText: "Mã học phần",
                hintStyle: TextStyle(color: AppColors.gray),
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.search, color: AppColors.gray),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: AppColors.gray),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: AppColors.gray),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: AppColors.gray),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
