import 'package:quranapp/model/assign/assign_instructor_response.dart';
import 'package:quranapp/model/group_response.dart';
import 'package:quranapp/model/instructor_response.dart';
import 'package:quranapp/model/student_response.dart';


abstract class AppState {}

class AppInitialState extends AppState {}

class GetInstructorLoadingState extends AppState {}

class GetInstructorSuccessState extends AppState {
  final InstructorResponse instructorResponse;

  GetInstructorSuccessState(this.instructorResponse);
}

class GetInstructorErrorState extends AppState {}

class InstructorSearchByNameLoadingState extends AppState {}

class InstructorSearchByNameSuccessState extends AppState {
  final InstructorResponse instructorResponse;

  InstructorSearchByNameSuccessState(this.instructorResponse);
}

class InstructorSearchByNameErrorState extends AppState {}

class InstructorSearchByEmailLoadingState extends AppState {}

class InstructorSearchByEmailSuccessState extends AppState {
  final InstructorResponse instructorResponse;

  InstructorSearchByEmailSuccessState(this.instructorResponse);
}

class InstructorSearchByEmailErrorState extends AppState {}

class ChangeBottomSheetIcon extends AppState {}

class AppChangeDrawerScreenState extends AppState {}

class ChangeSearchState extends AppState {}

class ChangeListTileSelectedState extends AppState {}

class ChangeSelectedStudentState extends AppState {}

class CreateInstructorLoadingState extends AppState {}

class CreateInstructorSuccessState extends AppState {}

class CreateInstructorErrorState extends AppState {}

class UpdateInstructorLoadingState extends AppState {}

class UpdateInstructorSuccessState extends AppState {}

class UpdateInstructorErrorState extends AppState {}

class DeleteInstructorLoadingState extends AppState {}

class DeleteInstructorSuccessState extends AppState {}

class DeleteInstructorErrorState extends AppState {}

class GetStudentLoadingState extends AppState {}

class GetStudentSuccessState extends AppState {
  final StudentResponse studentResponse;

  GetStudentSuccessState(this.studentResponse);
}

class GetStudentErrorState extends AppState {}

class CreateStudentLoadingState extends AppState {}

class CreateStudentSuccessState extends AppState {}

class CreateStudentErrorState extends AppState {}

class UpdateStudentLoadingState extends AppState {}

class UpdateStudentSuccessState extends AppState {}

class UpdateStudentErrorState extends AppState {}

class DeleteStudentLoadingState extends AppState {}

class DeleteStudentSuccessState extends AppState {}

class DeleteStudentErrorState extends AppState {}

class StudentSearchByNameLoadingState extends AppState {}

class StudentSearchByNameSuccessState extends AppState {}

class StudentSearchByNameErrorState extends AppState {}

class StudentSearchByEmailLoadingState extends AppState {}

class StudentSearchByEmailSuccessState extends AppState {}

class StudentSearchByEmailErrorState extends AppState {}

class GetGroupLoadingState extends AppState {}

class GetGroupSuccessState extends AppState {
  final GroupResponse groupResponse;

  GetGroupSuccessState(this.groupResponse);
}

class GetGroupErrorState extends AppState {}

class CreateGroupLoadingState extends AppState {}

class CreateGroupSuccessState extends AppState {}

class CreateGroupErrorState extends AppState {}

class UpdateGroupLoadingState extends AppState {}

class UpdateGroupSuccessState extends AppState {}

class UpdateGroupErrorState extends AppState {}

class DeleteGroupLoadingState extends AppState {}

class DeleteGroupSuccessState extends AppState {}

class DeleteGroupErrorState extends AppState {}

class GroupSearchByNameLoadingState extends AppState {}

class GroupSearchByNameSuccessState extends AppState {}

class GroupSearchByNameErrorState extends AppState {}

class AssignInstructorToGroupLoadingState extends AppState {}

class AssignInstructorToGroupSuccessState extends AppState {
  final AssignInstructorResponse assignInstructorResponse;

  AssignInstructorToGroupSuccessState(this.assignInstructorResponse);
}

class AssignInstructorToGroupErrorState extends AppState {}

class GetAssignInstructorLoadingState extends AppState {}

class GetAssignInstructorSuccessState extends AppState {}

class GetAssignInstructorErrorState extends AppState {}

class AssignStudentToGroupLoadingState extends AppState {}

class AssignStudentToGroupSuccessState extends AppState {}

class AssignStudentToGroupErrorState extends AppState {}

class LogoutLoadingState extends AppState {}

class LogoutSuccessState extends AppState {}

class LogoutErrorState extends AppState {}
