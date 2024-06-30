class ApiPath {

  static const local = "http://103.138.113.14/nodejs";
  // static const local = "https://8dae-14-232-160-63.ngrok-free.app";

  static const signUpStudent = '$local/api/students';
  static const logInStudent = '$local/api/students/login';
  static const logInTeacher = '$local/api/teachers/login';
  static const signUpTeacher = '$local/api/teachers';
  static const listSubject= '$local/api/subjects';
  static const addClass= '$local/api/classes';
  static const addClassContents= '$local/api/classContents';
  static const getListStudent= '$local/api/classContents/getListStudent';
  static const updatePointForStudent= '$local/api/classContents/updatePoint';
  static const listTest= '$local/api/tests';
  static const listTestStudent= '$local/api/tests/student/';
  static const getTest= '$local/api/tests/getTest/';
  static const submitAssignment= '$local/api/assignment';
  static const getAssgnment= '$local/api/assignment';
  static const getAttendance= '$local/api/attendance/doattendance';
  static const getStatusLock= '$local/api/attendance/getlock';
  static const studyDocument= '$local/api/studydocument';
  static const addStudentToClass= '$local/api/classContents/addListStudent';
  static const updateStudent= '$local/api/attendance/studentupdate';
  static const getListLROfStudent= '$local/api/leavereaquest/lrinclass';
  static const sendLeaveRequest= '$local/api/leavereaquest/';

}