part of 'study_document_bloc.dart';

sealed class StudyDocumentEvent {}

final class InitGetListStudyEvent extends StudyDocumentEvent{
  final String classID;
  InitGetListStudyEvent({required this.classID});
}

final class AddLinkStudyEvent extends StudyDocumentEvent{
  final String link;
  AddLinkStudyEvent({required this.link});
}
