import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:intl/intl.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/to_do_class_student/bloc/study_document_bloc.dart';

class StudyDocumentStudentView extends StatefulWidget {
  final String classID;
  const StudyDocumentStudentView({super.key, required this.classID});

  @override
  State<StudyDocumentStudentView> createState() =>
      _StudyDocumentStudentViewState();
}

class _StudyDocumentStudentViewState extends State<StudyDocumentStudentView> {
  Map<String, PreviewData> datas = {};

  @override
  void initState() {
    BlocProvider.of<StudyDocumentBloc>(context)
        .add(InitGetListStudyEvent(classID: widget.classID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudyDocumentBloc, StudyDocumentState>(
      builder: (context, state) {
        if (state.status == StudyStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == StudyStatus.failure) {
          return const Center(
            child: Text("ERROR"),
          );
        } else {
          List<String>  urls = state.listStudyDocument!.map((e) => e.dataLink!).toList() ;
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.listStudyDocument!.length,
              itemBuilder: (context, index) => InkWell(
            onTap: () async {
              // if (!await launchUrl(Uri.parse(state
              //         .listStudyDocument![
              //             state.listStudyDocument!.length - 1 - index]
              //         .dataLink ??
              //     "google.com"))) {
              //   throw 'Could not launch url';
              // }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "${state.listStudyDocument![state.listStudyDocument!.length - 1 - index].dataLink}",
                //   style: AppTextStyles.text13W500Black.copyWith(
                //       decoration: TextDecoration.underline),
                // ),
                LinkPreview(
                  hideImage: false,
                  
                  padding: EdgeInsets.all(20),
                  enableAnimation: true,
                  onPreviewDataFetched: (data) {
                    setState(() {
                      datas = {
                        ...datas,
                        urls[index]: data,
                      };
                    });
                  },
                  previewData: datas[urls[index]],
                  text: state.listStudyDocument![index].dataLink!,
                  width: MediaQuery.of(context).size.width,
                ),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      DateFormat('hh:mma -- dd-MM-yyyy').format(state
                          .listStudyDocument![
                              state.listStudyDocument!.length -
                                  1 -
                                  index]
                          .createdAt!),
                      style: AppTextStyles.text12W500Gray,
                    ),
                  ],
                )
              ],
            ),
              ),
            ),
          );
        }
      },
    );
  }
}
