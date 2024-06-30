import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qldtandroid/models/study_document_model.dart';
import 'package:qldtandroid/repo/logger.dart';
import 'package:qldtandroid/repo/study_document_repo.dart';

part 'study_document_event.dart';
part 'study_document_state.dart';

class StudyDocumentBloc extends Bloc<StudyDocumentEvent, StudyDocumentState> {
  late String classID;
  List<StudyDocumentModel> listStudyDocument = [];
  StudyDocumentBloc() : super(const StudyDocumentState()) {
    on<StudyDocumentEvent>((event, emit) {});
    on<InitGetListStudyEvent>(_onShowListStudy);
    on<AddLinkStudyEvent>(_onAddLink);
  }

  Future<void> _onShowListStudy(
      InitGetListStudyEvent event, Emitter<StudyDocumentState> emit) async {
    try {
      emit(state.copyWith(status: StudyStatus.initial));
      classID = event.classID;
      listStudyDocument = await StudyRepo().getListLink(classID: event.classID);
      // logger.log("show",color: StrColor.green);

      emit(state.copyWith(
          status: StudyStatus.success, listStudyDocument: listStudyDocument));
    } catch (e) {
      logger.log('show list test error : $e');
    }
  }

  Future<void> _onAddLink(
      AddLinkStudyEvent event, Emitter<StudyDocumentState> emit) async {
    try {
      if (event.link != "") {
        await StudyRepo().addLink(link: event.link, classID: classID);
        add(InitGetListStudyEvent(classID: classID));
      }
    } catch (e) {
      logger.log('show list test error : $e');
    }
  }
}
