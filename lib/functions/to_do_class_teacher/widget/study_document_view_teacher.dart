import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:intl/intl.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/to_do_class_student/bloc/study_document_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class StudyDocumentViewTeacher extends StatefulWidget {
  final String classID;

  const StudyDocumentViewTeacher({super.key, required this.classID});

  @override
  State<StudyDocumentViewTeacher> createState() =>
      _StudyDocumentViewTeacherState();
}

class _StudyDocumentViewTeacherState extends State<StudyDocumentViewTeacher> {
  Map<String, PreviewData> datas = {};
  final TextEditingController _editLinkController = TextEditingController();

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
          List<String> urls =
              state.listStudyDocument!.map((e) => e.dataLink!).toList();
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
                          LinkPreview(
                            hideImage: false,
                            onLinkPressed: (p0) async {
                              if (!await launchUrl(Uri.parse(
                                  state.listStudyDocument![index].dataLink ??
                                      "google.com"))) {
                                throw 'Could not launch url';
                              }
                            },
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
                                DateFormat('hh:mma -- dd-MM-yyyy').format(
                                    state.listStudyDocument![index].createdAt!),
                                style: AppTextStyles.text12W500Gray,
                              ),
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    ),
                  ),
                ),
                sendData()
              ],
            ),
          );
        }
      },
    );
  }

  Widget sendData() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration:
          const BoxDecoration(border: Border(top: BorderSide(width: 2))),
      child: Row(
        children: [
          Center(
            child: InkWell(
              onTap: () => BlocProvider.of<StudyDocumentBloc>(context)
                  .add(AddLinkStudyEvent(link: _editLinkController.text)),
              child: Icon(Icons.send),
            ),
          ),
          Expanded(
            child: TextFormField(
              onFieldSubmitted: (value) =>
                  BlocProvider.of<StudyDocumentBloc>(context)
                      .add(AddLinkStudyEvent(link: _editLinkController.text)),
              controller: _editLinkController,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.tundora,
              ),
              // decoration: AppFormField.inputDecorationLight.copyWith(
              //   enabledBorder: AppBorderAndRadius.outlineInputBorder.copyWith(
              //     borderRadius: BorderRadius.circular(20),
              //       borderSide: const BorderSide(color: AppColors.gray)),
              //   focusedBorder: AppBorderAndRadius.outlineInputBorder.copyWith(
              //     borderRadius: BorderRadius.circular(20),
              //       borderSide: const BorderSide(color: AppColors.red)),
              //   hintText: "link",
              //   hintStyle: const TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.w400,
              //       color: AppColors.gray),
              // prefixIcon: Container(
              //   padding:
              //       const EdgeInsets.only(left: 10),
              //   child: SvgPicture.asset(
              //     Images.ic_person_setup,
              //     height: 20,
              //     width: 20,
              //     color: AppColors.grey666,
              //   ),
              // ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
