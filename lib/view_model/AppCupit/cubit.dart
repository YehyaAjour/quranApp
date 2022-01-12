import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranapp/model/assign/assign_instructor_response.dart';
import 'package:quranapp/model/get_instructor_response.dart';
import 'package:quranapp/model/group_response.dart';
import 'package:quranapp/model/instructor_response.dart';
import 'package:quranapp/model/student_response.dart';
import 'package:quranapp/services/DioHelper/dio_helper.dart';
import 'package:quranapp/services/endpoint/end_points.dart';
import 'package:quranapp/view/groups/groups_screen.dart';
import 'package:quranapp/view/instructorscreen/instructor_screen.dart';
import 'package:quranapp/view/student/student_screen.dart';
import 'package:quranapp/view_model/AppStates/state.dart';


class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isBottomSheetShown = false;
  IconData floatIcon = Icons.add;

  void changeBottomSheet({@required bool sheetShow, @required icon}) {
    isBottomSheetShown = sheetShow;
    floatIcon = icon;
    emit(ChangeBottomSheetIcon());
  }

  int currentIndex = 0;
  List<Widget> drawerScreen = [
    InstructorScreen(),
    GroupsScreen(),
    StudentScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeDrawerScreenState());
  }

  bool isSearching = false;

  void changeSearchState({@required bool isSearchingShown}) {
    isSearching = isSearchingShown;
    emit(ChangeSearchState());
  }

  var dropDownList = ["Name", "Email", "Search By"];
  var selected = "Search By";

  List<int> selectedStudent = [];
  bool isAdding = false;
  void changeSelectedStudent(bool isSelected) {
    isAdding = isSelected != null && isSelected;
    emit(ChangeSelectedStudentState());
  }

  List<bool> selectedTile = [false];
  List<int> listTileSelectedStudent = [];
  void changeListTileSelectedStudent(int i) {
    selectedTile[i] = !selectedTile[i];
    emit(ChangeListTileSelectedState());
  }

  InstructorResponse instructorResponse;
  StudentResponse studentResponse;
  GroupResponse groupResponse;
  AssignInstructorResponse assignInstructorResponse;
  GetInstructorResponse getInstructorResponse;

  Future<void> getInstructor() async {
    emit(GetInstructorLoadingState());

    await DioHelper.getData(
      url: LISTINSTRUCTORS,
    ).then((value) {
      //print(value.data);
      instructorResponse = InstructorResponse.fromJson(value.data);

      emit(GetInstructorSuccessState(instructorResponse));
    }).catchError((error) {
      emit(GetInstructorErrorState());
    });
  }

  Future<void> getInstructorSearchByName({
    @required String nameSearch,
    @required String emailSearch,
  }) async {
    emit(InstructorSearchByNameLoadingState());

    await DioHelper.getData(
        url: LISTINSTRUCTORS,
        queries: {'name': nameSearch, 'email': emailSearch}).then((value) {
      //print(value.data);
      instructorResponse = InstructorResponse.fromJson(value.data);

      emit(InstructorSearchByNameSuccessState(instructorResponse));
    }).catchError((error) {
      emit(InstructorSearchByNameErrorState());
      print(error.toString());
    });
  }

  Future<void> getInstructorSearchByEmail({
    @required String emailSearch,
  }) async {
    emit(InstructorSearchByEmailLoadingState());

    await DioHelper.getData(
        url: LISTINSTRUCTORS, queries: {'email': emailSearch}).then((value) {
      instructorResponse = InstructorResponse.fromJson(value.data);

      emit(InstructorSearchByEmailSuccessState(instructorResponse));
    }).catchError((error) {
      emit(InstructorSearchByEmailErrorState());
      print(error.toString());
    });
  }

  Future<void> createInstructor(
      {@required String name, @required String email, String password}) async {
    emit(CreateInstructorLoadingState());

    await DioHelper.postData(
      url: CREATEINSTRUCTOR,
      data: {'name': name, 'email': email, 'password': password},
    ).then((value) {
      print(value.data);
      //  createInstructorResponse = CreateInstructorResponse.fromJson(value.data);
      getInstructor();
      //print(loginResponse.result);
      emit(CreateInstructorSuccessState());
    }).catchError((error) {
      emit(CreateInstructorErrorState());
      print(error.toString());
    });
  }

  Future<void> updateInstructor({
    @required int id,
    @required String name,
    @required String email,
    @required String password,
  }) async {
    emit(UpdateInstructorLoadingState());

    await DioHelper.updateData(
      url: UPDATEINSTRUCTOR,
      data: dataUpdateInstructor(
          id: id, name: name, email: email, password: password),
    ).then((value) {
      getInstructor();
      //  print(value.data);
      // createInstructorResponse = CreateInstructorResponse.fromJson(value.data);
      //print(loginResponse.result);
      emit(UpdateInstructorSuccessState());
    }).catchError((error) {
      emit(UpdateInstructorErrorState());
      print(error.toString());
    });
  }

  Future<void> deleteInstructor({
    @required int id,
  }) async {
    emit(DeleteInstructorLoadingState());

    await DioHelper.deleteData(
      url: DELETEINSTRUCTOR,
      data: {'instructor_id': id},
    ).then((value) {
      getInstructor();
      //  print(value.data);
      // createInstructorResponse = CreateInstructorResponse.fromJson(value.data);
      //print(loginResponse.result);
      emit(DeleteInstructorSuccessState());
    }).catchError((error) {
      emit(DeleteInstructorErrorState());
      print(error.toString());
    });
  }

  Future<void> getStudent() async {
    emit(GetStudentLoadingState());

    await DioHelper.getData(
      url: LISTSTUDENTS,
    ).then((value) {
      //print(value.data);
      studentResponse = StudentResponse.fromJson(value.data);

      emit(GetStudentSuccessState(studentResponse));
    }).catchError((error) {
      emit(GetStudentErrorState());
      print(error.toString());
    });
  }

  Future<void> createStudent(
      {@required String name, @required String email, String password}) async {
    emit(CreateStudentLoadingState());

    await DioHelper.postData(
      url: CREATESTUDENT,
      data: {'name': name, 'email': email, 'password': password},
    ).then((value) {
      getStudent();

      emit(CreateStudentSuccessState());
    }).catchError((error) {
      emit(CreateStudentErrorState());
      print(error.toString());
    });
  }

  Future<void> updateStudent({
    @required int id,
    @required String name,
    @required String email,
    @required String password,
  }) async {
    emit(UpdateStudentLoadingState());

    await DioHelper.updateData(
      url: UPDATEStudent,
      data: dataUpdateStudent(
          id: id, name: name, email: email, password: password),
    ).then((value) {
      getStudent();

      emit(UpdateStudentSuccessState());
    }).catchError((error) {
      emit(UpdateStudentErrorState());
      print(error.toString());
    });
  }

  Future<void> deleteStudent({
    @required int id,
  }) async {
    emit(DeleteStudentLoadingState());

    await DioHelper.deleteData(
      url: DELETESTUDENT,
      data: {'student_id': id},
    ).then((value) {
      getStudent();

      emit(DeleteStudentSuccessState());
    }).catchError((error) {
      emit(DeleteStudentErrorState());
      print(error.toString());
    });
  }

  Future<void> getStudentSearchByName({
    @required String nameSearch,
    @required String emailSearch,
  }) async {
    emit(StudentSearchByNameLoadingState());

    await DioHelper.getData(
        url: LISTSTUDENTS,
        queries: {'name': nameSearch, 'email': emailSearch}).then((value) {
      studentResponse = StudentResponse.fromJson(value.data);

      emit(StudentSearchByNameSuccessState());
    }).catchError((error) {
      emit(StudentSearchByNameErrorState());
      print(error.toString());
    });
  }

  Future<void> getStudentSearchByEmail({
    @required String emailSearch,
  }) async {
    emit(StudentSearchByEmailLoadingState());

    await DioHelper.getData(url: LISTSTUDENTS, queries: {'email': emailSearch})
        .then((value) {
      //print(value.data);
      studentResponse = StudentResponse.fromJson(value.data);

      emit(StudentSearchByEmailSuccessState());
    }).catchError((error) {
      emit(StudentSearchByEmailErrorState());
      print(error.toString());
    });
  }

  Future<void> getGroup() async {
    emit(GetGroupLoadingState());

    await DioHelper.getData(
      url: LISTGROUPS,
    ).then((value) {
      //print(value.data);
      groupResponse = GroupResponse.fromJson(value.data);

      emit(GetGroupSuccessState(groupResponse));
    }).catchError((error) {
      emit(GetGroupErrorState());
      print(error.toString());
    });
  }

  Future<void> createGroup({
    @required String name,
  }) async {
    emit(CreateGroupLoadingState());

    await DioHelper.postData(
      url: CREATEGROUP,
      data: {
        'name': name,
      },
    ).then((value) {
      print(value);
      getGroup();

      emit(CreateGroupSuccessState());
    }).catchError((error) {
      emit(CreateGroupErrorState());
      print(error.toString());
    });
  }

  Future<void> updateGroup({
    @required int id,
    @required String name,
  }) async {
    emit(UpdateGroupLoadingState());

    await DioHelper.updateData(
      url: UPDATEGROUP,
      data: {'group_id': id, 'name': name},
    ).then((value) {
      print(value);
      getGroup();

      emit(UpdateGroupSuccessState());
    }).catchError((error) {
      emit(UpdateGroupErrorState());
      print(error.toString());
    });
  }

  Future<void> deleteGroup({
    @required int id,
  }) async {
    emit(DeleteGroupLoadingState());

    await DioHelper.deleteData(
      url: DELETEGROUP,
      data: {'group_id': id},
    ).then((value) {
      print(value);
      getGroup();

      emit(DeleteGroupSuccessState());
    }).catchError((error) {
      emit(DeleteGroupErrorState());
      print(error.toString());
    });
  }

  Future<void> getGroupSearchByName({
    @required String nameSearch,
    @required String emailSearch,
  }) async {
    emit(GroupSearchByNameLoadingState());

    await DioHelper.getData(
        url: LISTGROUPS,
        queries: {'name': nameSearch, 'email': emailSearch}).then((value) {
      groupResponse = GroupResponse.fromJson(value.data);

      emit(GroupSearchByNameSuccessState());
    }).catchError((error) {
      emit(GroupSearchByNameErrorState());
      print(error.toString());
    });
  }

  Future<void> assignInstructorToGroup({
    @required int groupId,
    @required int instructorId,
  }) async {
    emit(AssignInstructorToGroupLoadingState());

    await DioHelper.postData(
      url: ASSIGNINSTRUCTOR,
      data: {
        'group_id': groupId,
        'instructor_id': instructorId,
      },
    ).then((value) {
      assignInstructorResponse = AssignInstructorResponse.fromJson(value.data);
      print(assignInstructorResponse);

      emit(AssignInstructorToGroupSuccessState(assignInstructorResponse));
    }).catchError((error) {
      emit(AssignInstructorToGroupErrorState());
      print(error.toString());
    });
  }

  Future<void> getAssignInstructor(int instructor_id) async {
    emit(GetAssignInstructorLoadingState());

    await DioHelper.getData(
        url: GETASSIGNINSTRUCTOR,
        queries: {'instructor_id': instructor_id}).then((value) {
      getInstructorResponse = GetInstructorResponse.fromJson(value.data);

      emit(GetAssignInstructorSuccessState());
    }).catchError((error) {
      emit(GetAssignInstructorErrorState());
      print(error.toString());
    });
  }

  Future<void> assignStudentToGroup({
    @required int groupId,
    @required List<int> studentsId,
  }) async {
    emit(AssignStudentToGroupLoadingState());

    await DioHelper.postData(
      url: ASSIGNSTUDENT,
      data: {
        'group_id': groupId,
        'students_id': studentsId,
      },
    ).then((value) {
      emit(AssignStudentToGroupSuccessState());
    }).catchError((error) {
      emit(AssignStudentToGroupErrorState());
      print(error.toString());
    });
  }

  Future<void> userLogout() async {
    emit(LogoutLoadingState());

    await DioHelper.postData(
      url: LOGOUT,
      // token: CacheHelper.getToken(key: 'token')
    ).then((value) {
      // loginResponse = LoginResponse.fromJson(value.data);
      //  print(loginResponse.result);
      emit(LogoutSuccessState());
    }).catchError((error) {
      emit(LogoutErrorState());
      print(error.toString());
    });
  }

  static Map<String, dynamic> dataUpdateInstructor({
    @required int id,
    @required String name,
    @required String email,
    @required String password,
  }) {
    Map<String, dynamic> data;
    if (name != null && email != null) {
      data = {
        'instructor_id': id,
        'name': name,
        'email': email,
      };
    } else if (name != null) {
      data = {
        'instructor_id': id,
        'name': name,
      };
    } else if (email != null) {
      data = {
        'instructor_id': id,
        'email': email,
      };
    } else {
      print("update failed");
    }
    return data;
  }

  static Map<String, dynamic> dataUpdateStudent({
    @required int id,
    @required String name,
    @required String email,
    @required String password,
  }) {
    Map<String, dynamic> data;
    if (name != null && email != null) {
      data = {
        'student_id': id,
        'name': name,
        'email': email,
      };
    } else if (name != null) {
      data = {
        'student_id': id,
        'name': name,
      };
    } else if (email != null) {
      data = {
        'student_id': id,
        'email': email,
      };
    } else {
      print("update failed");
    }
    return data;
  }
}
