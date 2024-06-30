part of 'study_document_bloc.dart';

enum StudyStatus {
  initial,
  addSuccess,
  success,
  failure,
}

final class StudyDocumentState extends Equatable {
  final StudyStatus status ;
  final List<StudyDocumentModel>? listStudyDocument;
  const StudyDocumentState({this.status = StudyStatus.initial,this.listStudyDocument});
  
  StudyDocumentState copyWith({StudyStatus? status, List<StudyDocumentModel>? listStudyDocument}){
    return StudyDocumentState(
      status: status ?? this.status,
      listStudyDocument:  listStudyDocument ?? this.listStudyDocument
    );
  }

  @override
  List<Object> get props => [
    status,
    listStudyDocument ?? []
  ];
}

